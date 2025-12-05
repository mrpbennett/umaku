#!/bin/bash

sudo apt install zsh -y

# make zsh default
sudo chsh -s $(which zsh) $USER

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh syntax highlighting and auto suggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure the zsh shell using umaku defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
cp ~/.local/share/umaku/configs/zshrc ~/.zshrc

# Load the PATH for use later in the installers
source ~/.local/share/umaku/defaults/zsh/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using umaku defaults
cp ~/.local/share/umaku/configs/inputrc ~/.inputrc
