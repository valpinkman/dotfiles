alias p='cd ~/Projects/'
alias sourcezsh='source ~/.zshrc'
alias dot='cd ~/dotfiles'
alias psgrep='ps aux | grep -v grep | grep -i '

#mkdir, cd into it
mkcd () {
  mkdir -p "$*"
  cd "$*"
}

# PR
function hubpr () {
  local branchName
  branchName=$(git branch | grep '\*' | sed -E 's/ *\* (.*)/\1/g')
  hub pull-request -h "valpinkman:$branchName"
}