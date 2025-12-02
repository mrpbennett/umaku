#!/bin/bash

# This script installs btop, a resource monitor that shows usage and stats for processor, memory, disks, network and processes.
sudo apt install -y btop

# Use Omakub btop config
mkdir -p ~/.config/btop/themes
cp ~/umaku/configs/btop.conf ~/.config/btop/btop.conf
cp ~/umaku/themes/catppuccin/btop.theme ~/.config/btop/themes/catppuccin.theme
