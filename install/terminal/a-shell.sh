#!/bin/bash

sudo apt install zsh

# make zsh default
sudo chsh -s $(which zsh)

# Configure the bash shell using Umaku defaults
[ -f ~/.local/share/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
cp ~/.local/share/umaku/configs/.zshrc ~/.zshhrc

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Umaku defaults
cp ~/.local/share/umaku/configs/inputrc ~/.inputrc

# ZSH auto suggestions & syntax highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
