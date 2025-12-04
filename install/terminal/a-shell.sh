#!/bin/bash

# Configure the bash shell using umaku defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/umaku/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/umaku/defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using umaku defaults
cp ~/.local/share/umaku/configs/inputrc ~/.inputrc
