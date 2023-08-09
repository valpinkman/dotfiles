#!/bin/bash
############################
# install.sh
############################

dir=~/dotfiles                     # dotfiles directory
olddir=~/dotfiles_old              # old dotfiles backup directory
ssh=~/.ssh                        # ssh directory
bin=~/.bin                        # user bin directory
fish=~/.config/fish
files="gemrc gitconfig gitignore vimrc"    # list of files/folders to symlink in homedir

echo "Installing xcode-stuff"
xcode-select --install
echo "done"

if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "done"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

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

echo "Setting Fish as shell..."
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
fish
echo "done"

set -U fish_user_paths /opt/homebrew/bin $fish_user_paths

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

echo "Moving existing .config/fish to $olddir"
mv $fish $olddir/fish
echo "done"

echo "Linking fish config"
ln -s $dir/fish $fish
echo "done"

echo "Linking starship complete"
mkdir -p ~/.config
ln -s $dir/starship.toml ~/.config/starship.toml
echo "done"

# echo "Installing zsh completions"
# mkdir -p ~/.zsh
# cd ~/.zsh
# wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh
# wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh
# echo "Done"

echo "Creating $bin if it doesn't exist already"
mkdir -p $bin
echo "done"

killall Finder