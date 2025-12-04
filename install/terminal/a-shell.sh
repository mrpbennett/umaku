#!/bin/bash

sudo apt install zsh

# make zsh default
sudo chsh -s $(which zsh)

# Configure the bash shell using Umaku defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshhrc.bak
cp ~/umaku/configs/zshhrc ~/.zshhrc

# Load the PATH for use later in the installers
source ~/umaku/defaults/zsh/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Umaku defaults
cp ~/umaku/configs/inputrc ~/.inputrc
