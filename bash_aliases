alias p='cd ~/Projects/'
alias sourcezsh='source ~/.zshrc'
alias dot='cd ~/dotfiles'
alias psgrep='ps aux | grep -v grep | grep -i '

#mkdir, cd into it
mkcd () {
mkdir -p "$*"
cd "$*"
}