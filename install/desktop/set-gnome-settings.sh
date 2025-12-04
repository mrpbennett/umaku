#!/bin/bash

# Center new windows in the middle of the screen
gsettings set org.gnome.mutter center-new-windows true

# Set Cascadia Mono as the default monospace font
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 13'

# Reveal week numbers in the Gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# Turn off ambient sensors for setting screen brightness (they rarely work well!)
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

#
#  Dock settings --
#

# Set dock to bottom of the screen
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM

# Disable panel mode (makes it floating)
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# Enable transparency
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5

# Center the dock (optional)
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
