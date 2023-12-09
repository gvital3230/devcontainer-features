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
ln -s /usr/local/lib/nvim/squashfs-root/AppRun /usr/local/bin

echo "Installing lazygit"
wget https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz
tar -xvzf lazygit_0.40.2_Linux_x86_64.tar.gz lazygit -C /usr/local/bin

echo "Installing fzf and ripgrep"
apt-get install -y fzf ripgrep
