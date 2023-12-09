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

create_folder_if_not_exists "$HOME/.local"
cd "$HOME/.local"

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract

create_folder_if_not_exists ~/.local/bin
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim
