#!/bin/bash

# Install Yazi from source
# Based on: https://yazi-rs.github.io/docs/installation#source

set -e  # Exit on error

# Check if rustup is installed
if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
fi

# Update Rust toolchain
rustup update

git clone https://github.com/sxyazi/yazi.git
cd yazi

# Build Yazi
cargo build --release --locked

# Install binaries
sudo mv target/release/yazi /usr/local/bin/
sudo mv target/release/ya /usr/local/bin/

# use the configs from umaku
rm -rf ~/.config/yazi
cp -R ~/.local/share/umaku/configs/yazi ~/.config/yazi
