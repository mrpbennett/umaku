#!/bin/bash

sudo apt install zsh

# make zsh default
sudo chsh -s $(which zsh)

# Configure the bash shell using Umaku defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
cp ~/umaku/configs/.zshrc ~/.zshhrc

# Set complete path
export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/umaku/bin:$PATH"
set +h

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Umaku defaults
cp ~/umaku/configs/inputrc ~/.inputrc
