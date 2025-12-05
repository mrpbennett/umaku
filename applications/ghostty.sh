#!/bin/bash

cat <<EOF >~/.local/share/applications/Ghostty.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Ghostty
Comment=Fast terminal emulator
Exec=/usr/local/bin/ghostty
Icon=ghostty
Terminal=false
Categories=System;TerminalEmulator;
EOF
