#!/bin/bash

# Gum is used for the umaku commands for tailoring umaku after the initial install
cd /tmp
GUM_VERSION="0.17.0"
wget -qO gum.rpm "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.rpm"
sudo dnf install -y ./gum.rpm
rm gum.rpm
cd -
