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
create_folder_if_not_exists "/usr/local/lib/nvim"
cd "/usr/local/lib/nvim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
ln -s /usr/local/lib/nvim/squashfs-root/AppRun /usr/local/bin/nvim

echo "Installing lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# echo "Installing fzf and ripgrep"
# apt-get install -y fzf ripgrep
