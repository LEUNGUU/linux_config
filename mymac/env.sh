# self-defined environment variables
export PYTHONIOENCODING=utf-8
export EDITOR='nvim'
alias quit='exit'
alias q='exit'
alias gclone='git clone '
alias gs='git status -s'
alias gmg='git commit -m'
alias gpo='git push origin '
alias gpom='git push origin master'
alias grebase2='git rebase -i HEAD~~'
alias vim="nvim "
alias gnew='function _new() { git checkout -b $1; git push origin $1 }; _new'

# go environment
export GOPATH=$HOME/go    # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# http proxy
function unset_httpproxy() {
    unset https_proxy; unset http_proxy
}

function ss_httpproxy() {
  export http_proxy=http://127.0.0.1:8838
  export https_proxy=http://127.0.0.1:8838
}
# git proxy
function ss_gitproxy() {
    git config --global https.proxy http://127.0.0.1:8838
    git config --global https.proxy https://127.0.0.1:8838
}

function unset_gitproxy() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

bindkey "jj" clear-screen

# for history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# CLI color
export CLICOLOR=1

export PATH=$PATH:/Users/admin/Library/Python/3.8/bin
