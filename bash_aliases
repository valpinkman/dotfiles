alias p='cd ~/Documents/Projects/'
alias sourcezsh='source ~/.zshrc'
alias dot='cd ~/dotfiles'

alias g='git'

#mkdir, cd into it
mkcd () {
mkdir -p "$*"
cd "$*"
}