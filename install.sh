#!/bin/bash
############################
# install.sh
############################

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
ssh=~/.ssh                        # ssh directory
bin=~/.bin                        # user bin directory
files="bash_aliases bash_profile gemrc gitconfig gitignore profile vimrc zshrc"    # list of files/folders to symlink in homedir

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
echo "done"

echo "Installing Brewfile..."
brew bundle
echo "done"

echo "Cleaning up..."
brew cleanup
echo "done"

echo "Setting ZSH as shell..."
chsh -s /bin/zsh
echo "done"

echo "Downloading Volta"
curl https://get.volta.sh | bash
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

echo "Linking starship complete"
mkdir -p ~/.config
ln -s $dir/starship.toml ~/.config/starship.toml
echo "done"

echo "Installing zsh completions"
mkdir -p ~/.zsh
cd ~/.zsh
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh
echo "Done"

echo "Creating $bin if it doesn't exist already"
mkdir -p $bin
echo "done"

killall Finder