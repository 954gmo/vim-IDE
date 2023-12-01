set -o vi
export PATH="/opt/homebrew/bin:${PATH}"
alias brew='/opt/homebrew/bin/brew'
alias rvim='/opt/homebrew/bin/vim'
alias cmake='/opt/homebrew/bin/cmake'
alias stop_vim='docker stop vim-ide'
alias start_vim='docker start vim-ide'
alias rm_vim='docker rm vim-ide'
alias ide_bash='docker exec -u ide -it --privileged vim-ide bash'
alias root_bash='docker exec -it --privileged vim-ide bash'

vim_ide(){
    if [[ $(docker ps |grep vim-ide | awk '{print $NF}') == 'vim-ide' ]]; then
        ide_bash
    else
        start_vim && ide_bash
    fi
}

vim_root_ide(){
    if [[ $(docker ps | grep vim-ide | awk '{print $NF}') == 'vim-ide' ]]; then
        root_bash
    else
        start_vim && root_bash
    fi
}

