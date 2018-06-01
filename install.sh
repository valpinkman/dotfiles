#!/bin/bash
############################
# install.sh
############################

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
ssh=~/.ssh                        # ssh directory
files="bash_aliases bash_profile gemrc gitconfig gitignore profile vimrc zshrc"    # list of files/folders to symlink in homedir

echo "Installing antigen"
curl -L git.io/antigen > $dir/antigen.zsh
echo "done"

echo "Installing xcode-stuff"
xcode-select --install
echo "done"

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "done"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Installing brew git utilities..."
brew install git-extras
brew install legit
brew install hub

echo "Installing other brew stuff..."
brew install nvm
brew install python
brew install python@2
brew install pipenv
brew install yarn

echo "Cleaning up brew"
brew cleanup
echo "done"

apps=(
    github
    gpg-suite
    iterm2
    keybase
    kid3
    postman
    spectacle
    visual-studio-code
    vox
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    qlvideo
    quicklook-csv
    quicklook-json
    suspicious-package
    webpquicklook
)

echo "installing apps with Cask..."
brew cask install ${apps[@]}

brew cask cleanup
brew cleanup
echo "done"

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

echo -n "Creating $ssh if it doesn't exist already"
mkdir -p $ssh
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "Moving existing .ssh/config to $olddir"
mv $ssh/config $olddir/config
echo "done"

echo "Linking ssh config"
ln -s $dir/config $ssh/config
echo "done"

killall Finder

source ~/.zshrc