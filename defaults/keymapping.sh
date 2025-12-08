#!/bin/bash

set -e

echo "=== Kanata Setup Script ==="
echo "This script will install Kanata and configure home row mods"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
   echo "Please do not run this script as root/sudo"
   exit 1
fi

# Install Rust if not already installed
if ! command -v cargo &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Install Kanata
echo "Installing Kanata..."
cargo install kanata

# Create config directory
echo "Creating config directory..."
mkdir -p "$HOME/.config/kanata"

# Create Kanata config file
echo "Creating Kanata configuration..."
cat > "$HOME/.config/kanata/kanata.kbd" << 'EOF'
(defcfg
  linux-dev /dev/input/by-path/platform-i8042-serio-0-event-kbd
)

(defsrc
  caps a s d f j k l ;
)

(deflayer base
  (tap-hold 100 100 esc lctl)
  (tap-hold 100 100 a lctl)
  (tap-hold 100 100 s lalt)
  (tap-hold 100 100 d lmet)
  (tap-hold 100 100 f lsft)
  (tap-hold 100 100 j rsft)
  (tap-hold 100 100 k rmet)
  (tap-hold 100 100 l ralt)
  (tap-hold 100 100 ; rctl)
)
EOF

echo "Configuration created at: $HOME/.config/kanata/kanata.kbd"

# Find the correct keyboard device
echo ""
echo "Detecting keyboard device..."
KEYBOARD_DEV=$(ls /dev/input/by-path/*-kbd 2>/dev/null | head -n 1)

if [ -z "$KEYBOARD_DEV" ]; then
    echo "Warning: Could not auto-detect keyboard device"
    echo "You may need to manually edit the config file"
else
    echo "Found keyboard: $KEYBOARD_DEV"
    sed -i "s|/dev/input/by-path/platform-i8042-serio-0-event-kbd|$KEYBOARD_DEV|" "$HOME/.config/kanata/kanata.kbd"
fi

# Create systemd service
echo "Creating systemd service..."
sudo tee /etc/systemd/system/kanata.service > /dev/null << EOF
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Type=simple
ExecStart=$HOME/.cargo/bin/kanata -c $HOME/.config/kanata/kanata.kbd
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
EOF

# Set up udev rules for permissions
echo "Setting up udev rules..."
sudo tee /etc/udev/rules.d/99-kanata.rules > /dev/null << EOF
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
EOF

# Add user to input group
echo "Adding user to input group..."
sudo usermod -aG input "$USER"

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Enable and start service
echo "Enabling Kanata service..."
sudo systemctl daemon-reload
sudo systemctl enable kanata.service

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Next steps:"
echo "1. Log out and log back in (required for group membership)"
echo "2. Start Kanata with: sudo systemctl start kanata"
echo "3. Check status with: sudo systemctl status kanata"
echo ""
echo "Your home row mods:"
echo "  a - tap: a, hold: left ctrl"
echo "  s - tap: s, hold: left alt"
echo "  d - tap: d, hold: super"
echo "  f - tap: f, hold: left shift"
echo "  j - tap: j, hold: right shift"
echo "  k - tap: k, hold: super"
echo "  l - tap: l, hold: right alt"
echo "  ; - tap: ;, hold: right ctrl"
echo "  caps - tap: esc, hold: left ctrl"
echo ""
echo "Config file: $HOME/.config/kanata/kanata.kbd"
echo "To edit: nano $HOME/.config/kanata/kanata.kbd"
echo "After editing, restart: sudo systemctl restart kanata"
