#!/bin/bash

set -e

# k9s installation script for Ubuntu
# Fetches the latest release from GitHub and installs it

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        K9S_ARCH="amd64"
        ;;
    aarch64|arm64)
        K9S_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Detected architecture: $K9S_ARCH"

# Get the latest version from GitHub
LATEST_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to fetch latest version"
    exit 1
fi

echo "Latest version: $LATEST_VERSION"

# Construct download URL
DOWNLOAD_URL="https://github.com/derailed/k9s/releases/download/${LATEST_VERSION}/k9s_Linux_${K9S_ARCH}.tar.gz"

# Create temporary directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Download the tarball
curl -LO "$DOWNLOAD_URL"

# Extract the tarball
echo "Extracting archive..."
tar -xzf "k9s_Linux_${K9S_ARCH}.tar.gz"

# Install k9s binary
echo "Installing k9s to /usr/local/bin..."
sudo install -m 755 k9s /usr/local/bin/k9s

# Clean up
cd -
rm -rf "$TMP_DIR"

# use the configs from umaku
rm -rf ~/.config/k9s
cp -R ~/.local/share/umaku/configs/k9s ~/.config/k9s

# Verify installation
if command -v k9s &> /dev/null; then
    echo "k9s installed successfully!"
    echo "Version: $(k9s version --short)"
else
    echo "Installation failed!"
    exit 1
fi
