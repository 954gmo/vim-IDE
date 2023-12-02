#!/bin/sh
echo "set -o vi" >> ~/.bashrc && source ~/.bashrc \
    && apt update && apt -y upgrade \
    && add-apt-repository -y ppa:jonathonf/vim \
    && apt update \
    && apt install -y  software-properties-common git build-essential libssl-dev wget curl vim python3.10-dev llvm  \
    && mkdir -p ~/.vim/bundle \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
    && curl -L https://raw.githubusercontent.com/954gmo/vim-IDE/main/vimrc_plugins > ~/.vimrc \
    && vim +PluginInstall +qall \
    && curl -L https://raw.githubusercontent.com/954gmo/vim-IDE/main/vimrc > ~/vimrc \
    && mv ~/vimrc ~/.vimrc \
    && vim +PluginInstall +qall \
    && wget -c https://github.com/Kitware/CMake/releases/download/v3.28.0-rc5/cmake-3.28.0-rc5.tar.gz \
    && tar -zxvf cmake-3.28.0-rc5.tar.gz -C /tmp \
    && rm cmake-3.28.0-rc5.tar.gz \
    && cd /tmp/cmake-3.28.0-rc5 && ./boostrap && make && make install \
    && python3 ~/.vim/plugged/YouCompleteMe/install.py --clangd-completer 
