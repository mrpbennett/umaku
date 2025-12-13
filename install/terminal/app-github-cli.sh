#!/bin/bash

if [ ! -f /etc/yum.repos.d/gh-cli.repo ]; then
    sudo dnf install -y 'dnf-command(config-manager)'
    sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
fi

sudo dnf install gh -y
