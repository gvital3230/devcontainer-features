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
# example tag_name: v0.28.2
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

echo "Installing ripgrep"
echo "=============================================="
# example tag_name: 0.28.2
RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -LO "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar xf ripgrep-"${RIPGREP_VERSION}"-*.tar.gz
cd ripgrep-"${RIPGREP_VERSION}"-x86_64-unknown-linux-musl
sudo install rg /usr/local/bin
