# ZSH_THEME=""
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
EDITOR="code"

# User configuration
PATH=$PATH
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/sbin
PATH=$PATH:/bin

export PATH
export NVM_DIR=~/.nvm
export ZSH=$HOME/.oh-my-zsh
export GPG_TTY=$(tty)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -s "$HOME/nvm.sh" ] && . "$HOME/nvm.sh"  # This loads nvm

# ssh
export SSH_KEY_PATH="~/.ssh/"

source $(brew --prefix nvm)/nvm.sh
source ~/antigen.zsh
source ~/.bash_aliases
source ~/.bash_profile
source ~/.profile

antigen use oh-my-zsh
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle paulirish/git-open
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

eval "$(pipenv --completion)"

unsetopt correct_all
setopt correct

autoload -U promptinit; promptinit
prompt pure