#!/bin/bash

# remove director if it exists
if [ -d "$HOME/.oh-my-zsh" ]; then
    rm -r "$HOME/.oh-my-zsh"
fi


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
