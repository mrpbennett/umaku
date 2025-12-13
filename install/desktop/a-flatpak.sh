#!/bin/bash

sudo dnf install -y flatpak
sudo dnf install -y gnome-software
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
