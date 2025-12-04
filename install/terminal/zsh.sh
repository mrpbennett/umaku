#!/bin/bash

# install zsh
sudo apt install zsh

# make zsh default
chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check if .zshrc exists and backup before replacing
if [ -f ~/.zshrc ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv ~/.zshrc ~/.zshrc.bak
fi

# Copy umaku config
cp ~/umaku/defaults/zsh/.zshrc ~/.zshrc

# Source the new config
source ~/.zshrc
