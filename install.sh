#!/bin/sh
if [ ! -x "$(command -v curl)" ]; then
    echo "Please install curl!"
    exit 1
fi

if [ ! -x "$(command -v git)" ]; then
    echo "Please install git!"
    exit 1
fi

VIMRC_PATH=$HOME/.config/nvim
if [ ! -d $VIMRC_PATH ]; then
    git clone https://github.com/mattxlee/config_nvim $VIMRC_PATH
fi
if [ ! -d $VIMRC_PATH ]; then
    echo "Cannot clone the repo!"
    return 1
fi
cd $VIMRC_PATH

cpfile() {
    if [ ! -f ~/$1 ]; then
        cp $1 ~/$1
        echo "copied $1"
    fi
}

if [ ! -x "$(command -v fzf)" ]; then
    echo "fzf cannot be found, you need to install it."
fi

clone_plugin() {
    SOURCE_URL=$1
    DEST_DIR=$2
    if [ ! -d $DEST_DIR ]; then
        git clone $SOURCE_URL $DEST_DIR
    fi
}

clone_plugin https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cpfile .editorconfig
cpfile .gitconfig
cpfile .gitignore_global
cpfile .tmux.conf
cpfile .zshrc

