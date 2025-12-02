#!/bin/bash

curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"

# set default theme
starship preset nerd-font-symbols -o ~/.config/starship.toml
