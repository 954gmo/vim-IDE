#!/bin/sh
brew install --cask docker
ln -s /usr/local/bin/docker /opt/homebrew/bin/docker

# on mac
open -a Docker
docker image ls
docker container ls

docker run -it -d --name vim-ide --mount type=bind,source="$(pwd)",target=/projects ubuntu:latest
docker start vim-ide
docker stop vim-ide
docker rm vim-ide

docker exec -it -u ide --privileged vim-ide bash

