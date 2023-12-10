#!/bin/bash
set -e

create_folder_if_not_exists() {
	local folder_path="$1"

	if [ ! -d "$folder_path" ]; then
		mkdir -p "$folder_path"
		echo "Folder created: $folder_path"
	else
		echo "Folder already exists: $folder_path"
	fi
}

echo "Installing neovim"
echo "=============================================="
create_folder_if_not_exists "/usr/local/lib/nvim"
cd "/usr/local/lib/nvim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
ln -s /usr/local/lib/nvim/squashfs-root/AppRun /usr/local/bin/nvim

echo "Installing lazygit"
echo "=============================================="
# example
# tag_name: v0.40.2
# file link: https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name | ltrimstr("v")')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

echo "Installing ripgrep"
echo "=============================================="
# example
# tag_name: 14.0.3
# file link: https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep-14.0.3-x86_64-unknown-linux-musl.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | jq -r '.tag_name')
curl -LO "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xf ripgrep-"${VERSION}"-*.tar.gz
cd ripgrep-"${VERSION}"-x86_64-unknown-linux-musl
sudo install rg /usr/local/bin

echo "Installing fd"
echo "=============================================="
# example
# tag_name: v8.7.1
# file link: https://github.com/sharkdp/fd/releases/download/v8.7.1/fd-v8.7.1-x86_64-unknown-linux-musl.tar.gz
VERSION=$(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | jq -r '.tag_name')
curl -LO "https://github.com/sharkdp/fd/releases/latest/download/fd-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xf fd-"${VERSION}"-*.tar.gz
cd fd-"${VERSION}"-x86_64-unknown-linux-musl
sudo install fd /usr/local/bin
