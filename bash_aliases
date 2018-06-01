alias p='cd ~/Projects/'
alias sourcezsh='source ~/.zshrc'
alias dot='cd ~/dotfiles'

#mkdir, cd into it
mkcd () {
mkdir -p "$*"
cd "$*"
}