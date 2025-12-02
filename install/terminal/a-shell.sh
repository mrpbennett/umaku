#!/bin/bash

# Configure the bash shell using Umaku defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshhrc.bak
cp ~/.local/share/umaku/configs/zshhrc ~/.zshhrc

# Load the PATH for use later in the installers
source ~/.local/share/umaku/defaults/zsh/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Umaku defaults
cp ~/.local/share/umaku/configs/inputrc ~/.inputrc
