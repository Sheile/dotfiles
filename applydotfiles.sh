#!/bin/sh

cd $(dirname $0)
if [ ! -d backup ]
then
    mkdir backup
fi

for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        if [ -f "$HOME/$dotfile" ] && [ ! -L "$HOME/$dotfile" ]
        then
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
