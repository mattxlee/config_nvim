#!/bin/sh
gitclone() {
	SRC=$1
	DEST=$2
	if [ ! -d $DEST ]; then
		git clone --depth 1 $SRC $DEST
	fi
}

cpfile() {
	FILE=$1
	if [ ! -f ~/$FILE ]; then
		cp $FILE ~/$FILE
		echo "copied: $FILE"
	fi
}

rmdir() {
	DIR=$1
	if [ -d $DIR ]; then
		echo "removing: $DIR"
		rm -rf $DIR
	fi
}

if [ $# -eq 0 ]; then
	gitclone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	gitclone https://github.com/mattxlee/config_nvim ~/.config/nvim
	cd ~/.config/nvim
	cpfile .clang-format
	cpfile .editorconfig
	cpfile .gitconfig
	cpfile .gitignore_global
    echo 'installing plugins...'
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1
	exit 0
fi

if [ $# -eq 1 ]; then
	if [ "$1" = "-u" ]; then
        echo 'removing nvim settings...'
		rmdir ~/.local/share/nvim
		rmdir ~/.config/nvim
	else
		echo "use -u to uninstall the script"
	fi
	exit 0
fi

