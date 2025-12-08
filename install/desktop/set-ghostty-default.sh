#!/usr/bin/env sh

# Make ghostty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/ghostty

# use the configs from umaku
rm -rf ~/.config/ghostty
cp -R ~/.local/share/umaku/configs/ghostty ~/.config/ghostty
