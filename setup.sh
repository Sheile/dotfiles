#!/bin/sh

cd $(dirname $0)
[ ! -d backup ] && mkdir backup

for dotfile in .?*; do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ]; then
        if [ -f "$HOME/$dotfile" ] && [ ! -L "$HOME/$dotfile" ]; then
            mv "$HOME/$dotfile" "$PWD/backup"
        fi
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done

# vim用にbackup/swapディレクトリ作成
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap

# submoduleの読み込み
git submodule update --init
