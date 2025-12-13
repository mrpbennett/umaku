#!/bin/bash

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo dnf update -y && sudo dnf install -y gpg wget curl
sudo dnf install -y 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
sudo dnf install -y mise

# Sets my languages
mise use --global node@lts
mise use --global go@latest
mise use --global python@latest
mise use --global java@latest
