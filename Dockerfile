FROM ubuntu:latest
# install essential developer package
RUN apt update && apt -y upgrade && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:jonathonf/vim && \
    apt update && \
    apt install -y git build-essential libssl-dev wget curl vim python3.10-dev llvm 


# compile and install the latest cmake
RUN wget -c https://github.com/Kitware/CMake/releases/download/v3.28.0-rc5/cmake-3.28.0-rc5.tar.gz && \
    tar -zxvf cmake-3.28.0-rc5.tar.gz -C /tmp && \
    rm cmake-3.28.0-rc5.tar.gz && \
    cd /tmp/cmake-3.28.0-rc5 && ./bootstrap && make && make install && rm -R /tmp/cmake-3.28.0-rc5

# add user ide
RUN useradd -m ide && echo "set -o vi" >> /home/ide/.bashrc 
ENV work_directory=/home/ide
USER ide
WORKDIR ${work_directory}

# set up vim ide
RUN mkdir -p ${work_directory}/.vim/bundle && \
    git clone https://github.com/VundleVim/Vundle.vim.git ${work_directory}/.vim/bundle/Vundle.vim && \
    curl -L https://raw.githubusercontent.com/954gmo/vim-IDE/main/vimrc_plugins > ${work_directory}/.vimrc &&  \
    vim +PluginInstall +qall && \
    python3 ${work_directory}/.vim/plugged/YouCompleteMe/install.py --clangd-completer  && \
    curl -L https://raw.githubusercontent.com/954gmo/vim-IDE/main/vimrc > ${work_directory}/.vimrc && \
    vim +PluginInstall +qall 
