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

# submoduleの読み込み
git submodule update --init

# vim用にbackup/swap/bundleディレクトリ作成
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/bundle

# NeoBundleへのリンク作成
ln -Fs "$PWD/neobundle.vim" "$HOME/.vim/bundle/neobundle.vim"

# vim用のcolor schemeへのリンク作成
mkdir -p ~/.vim/colors
ln -Fs "$PWD/desert256.vim/colors/desert256.vim" "$HOME/.vim/colors/desert256.vim"
