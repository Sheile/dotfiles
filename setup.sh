#!/usr/bin/env zsh

set -eu

mkdir -p "$PWD/tmp"

cd $(dirname $0)
[ ! -d backup ] && mkdir backup

for dotfile in .?*; do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ]; then
        if [ -f "$HOME/$dotfile" ] && [ ! -L "$HOME/$dotfile" ]; then
            mv "$HOME/$dotfile" "$PWD/backup"
        fi
        ln -fs "$PWD/$dotfile" $HOME
    fi
done

# submoduleの読み込み
git submodule update --init

# Build diff-highlight
make --directory externals/git/contrib/diff-highlight

# $HOME/binを作成して必要なスクリプトを配置
mkdir -p $HOME/bin
ln -fs "$PWD/externals/git/contrib/diff-highlight/diff-highlight" "$HOME/bin/"

# Setup antigen to manage zsh plugins
curl -L git.io/antigen > $HOME/.zsh/antigen.zsh

# Prepare directory for zsh completions
mkdir -p $HOME/.zsh/completions

autoload -U compinit
rm -f $HOME/.zcompdump; compinit
echo "[NOTICE] Please restart shell to apply completion for git"
