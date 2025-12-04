#!/bin/bash

set -e

ascii_art='
__    __                          __
/  |  /  |                        /  |
$$ |  $$ | _____  ____    ______  $$ |   __  __    __
$$ |  $$ |/     \/    \  /      \ $$ |  /  |/  |  /  |
$$ |  $$ |$$$$$$ $$$$  | $$$$$$  |$$ |_/$$/ $$ |  $$ |
$$ |  $$ |$$ | $$ | $$ | /    $$ |$$   $$<  $$ |  $$ |
$$ \__$$ |$$ | $$ | $$ |/$$$$$$$ |$$$$$$  \ $$ \__$$ |
$$    $$/ $$ | $$ | $$ |$$    $$ |$$ | $$  |$$    $$/
$$$$$$/  $$/  $$/  $$/  $$$$$$$/ $$/   $$/  $$$$$$/
'

echo -e "$ascii_art"
echo "=> Umaku is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Umaku..."
rm -rf ~/.local/share/umaku
git clone https://github.com/mrpbennett/umaku.git ~/.local/share/umaku >/dev/null
if [[ $UMAKU_REF != "master" ]]; then
	cd ~/.local/share/umaku
	git fetch origin "${UMAKU_REF:-stable}" && git checkout "${UMAKU_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/umaku/install.sh
