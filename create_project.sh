#!/bin/bash 

DEBUG_PATH=$1/debug
RELEASE_PATH=$1/release

mkdir -p $1/src $1/config $1/include  $1/gtests $1/lib \
        $1/file_tempaltes $1/scripts \
        ${DEBUG_PATH}/bin ${DEBUG_PATH}/build \
        ${RELEASE_PATH}/bin ${RELEASE_PATH}/build 

touch $1/CMakeLists.txt $1/config/config.h.in $1/gtests/CMakeLists.txt $1/.gitignore


cat <<EOT >> $1/CMakeLists.txt 
cmake_minimum_required(VERSION 3.25)

project($1 VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(INCLUDE \${CMAKE_CURRENT_SOURCE_DIR}/include)

configure_file(include/config.h.in 
    "\${INCLUDE}/config.h")
EOT

CONFIG=$(echo $1 | awk '{print toupper($0)}')

cat <<EOT >> $1/config/config.h.in

#ifndef ${CONFIG}_CONFIG_H
#define ${CONFIG}_CONFIG_H

#define VERSION_MAJOR @$1_VERSION_MAJOR@
#define VERSION_MINOR @$1_VERSION_MINOR@
#define VERSION_PATCH @$1_VERSION_PATCH@
#define VERSION_TWEAK @$1_VERSION_TWEAK@

#endif
EOT

cat <<EOT >> $1/gtests/CMakeLists.txt
include(FetchContent)
FetchContent_Declare(
        googletest
        # Specify the commit you depend on and update it regularly.
        URL https://github.com/google/googletest/archive/5376968f6948923e2411081fd9372e71a59d8e77.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)
EOT

cat <<EOT >>$1/.gitignore 
${DEBUG_PATH}
${RELEASE_PATH}
EOT
cd $1 && git init
