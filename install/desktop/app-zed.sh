#!/bin/bash

curl -f https://zed.dev/install.sh | sh

# use the configs from umaku
rm -rf ~/.config/zed
cp -R ~/.local/share/umaku/configs/zed ~/.config/zed
