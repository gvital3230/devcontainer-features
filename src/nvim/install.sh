#!/bin/bash

set -e

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

apt_get_update() {
  if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
    echo "Running apt-get update..."
    apt-get update -y
  fi
}

# Checks if packages are installed and installs them if not
check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt_get_update
    apt-get -y install --no-install-recommends "$@"
  fi
}

# Install dependencies
check_packages neovim curl ca-certificates jq

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"

echo ""
echo "Installing lazygit..."
echo "=============================================="
# example
# tag_name: v0.40.2
# file link: https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name | ltrimstr("v")')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
cp lazygit /usr/local/bin
echo "...Done"

echo ""
echo "Installing ripgrep"
echo "=============================================="
# example
# tag_name: 14.0.3
# file link: https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep-14.0.3-x86_64-unknown-linux-musl.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | jq -r '.tag_name')
curl -LO "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xf ripgrep-"${VERSION}"-*.tar.gz
cd ripgrep-"${VERSION}"-x86_64-unknown-linux-musl
cp rg /usr/local/bin
echo "...Done"

echo ""
echo "Installing fd"
echo "=============================================="
# example
# tag_name: v8.7.1
# file link: https://github.com/sharkdp/fd/releases/download/v8.7.1/fd-v8.7.1-x86_64-unknown-linux-musl.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | jq -r '.tag_name')
curl -LO "https://github.com/sharkdp/fd/releases/latest/download/fd-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xf fd-"${VERSION}"-*.tar.gz
cd fd-"${VERSION}"-x86_64-unknown-linux-musl
cp fd /usr/local/bin
echo "...Done"
