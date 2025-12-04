#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> umaku is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning umaku..."
rm -rf ~/.local/share/umaku
git clone https://github.com/basecamp/umaku.git ~/.local/share/umaku >/dev/null
if [[ $umaku_REF != "master" ]]; then
	cd ~/.local/share/umaku
	git fetch origin "${umaku_REF:-stable}" && git checkout "${umaku_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/umaku/install.sh
