#!/bin/bash

# Install Ghostty from source since there's no Fedora-specific installer yet
# Install dependencies first
sudo dnf install -y git zig

# Clone and build Ghostty
cd /tmp
git clone https://github.com/ghostty-org/ghostty.git
cd ghostty
zig build -Doptimize=ReleaseFast
sudo cp zig-out/bin/ghostty /usr/local/bin/
cd /tmp && rm -rf ghostty
