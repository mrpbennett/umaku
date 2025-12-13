#!/bin/bash

set -e

ascii_art='

                                   /$$
                                  | $$
 /$$   /$$ /$$$$$$/$$$$   /$$$$$$ | $$   /$$ /$$   /$$
| $$  | $$| $$_  $$_  $$ |____  $$| $$  /$$/| $$  | $$
| $$  | $$| $$ \ $$ \ $$  /$$$$$$$| $$$$$$/ | $$  | $$
| $$  | $$| $$ | $$ | $$ /$$__  $$| $$_  $$ | $$  | $$
|  $$$$$$/| $$ | $$ | $$|  $$$$$$$| $$ \  $$|  $$$$$$/
 \______/ |__/ |__/ |__/ \_______/|__/  \__/ \______/

'

echo -e "$ascii_art"
echo "=> umaku is for fresh Fedora 39+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo dnf update -y >/dev/null
sudo dnf install -y git >/dev/null

echo "Cloning umaku..."
rm -rf ~/.local/share/umaku
git clone https://github.com/mrpbennett/umaku.git ~/.local/share/umaku >/dev/null
if [[ $umaku_REF != "master" ]]; then
	cd ~/.local/share/umaku
	git fetch origin "${umaku_REF:-stable}" && git checkout "${umaku_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/umaku/install.sh
