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
