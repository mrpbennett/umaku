#!/bin/bash

set_font() {
	local font_name=$1
	local url=$2
	local file_type=$3
	local file_name="${font_name/ Nerd Font/}"

	if ! $(fc-list | grep -i "$font_name" >/dev/null); then
		cd /tmp
		wget -O "$file_name.zip" "$url"
		unzip "$file_name.zip" -d "$file_name"
		cp "$file_name"/*."$file_type" ~/.local/share/fonts
		rm -rf "$file_name.zip" "$file_name"
		fc-cache
		cd -
		clear
		source $UMAKU_PATH/ascii.sh
	fi

	gsettings set org.gnome.desktop.interface monospace-font-name "$font_name 10"
	cp "$UMAKU_PATH/configs/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml
	sed -i "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" ~/.config/Code/User/settings.json
}

if [ "$#" -gt 1 ]; then
	choice=${!#}
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi

case $choice in

"JetBrains Mono")
	set_font "JetBrainsMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" "ttf"
	;;
"> Change size")
	source $UMAKU_PATH/bin/umaku-sub/font-size.sh
	exit
	;;
esac

source $UMAKU_PATH/bin/umaku-sub/menu.sh
