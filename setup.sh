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

# vim用にbackup/swap/bundleディレクトリ作成
mkdir -p $HOME/.vim/backup
mkdir -p $HOME/.vim/swap
mkdir -p $HOME/.vim/bundle

# NeoBundleのインストール
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > "$PWD/tmp/neobundle_install.sh"
chmod a+x "$PWD/tmp/neobundle_install.sh"
$PWD/tmp/neobundle_install.sh

# vim用のcolor schemeへのリンク作成
mkdir -p $HOME/.vim/colors
ln -fs "$PWD/desert256.vim/colors/desert256.vim" "$HOME/.vim/colors/desert256.vim"

# $HOME/binを作成して必要なスクリプトを配置
mkdir -p $HOME/bin
ln -fs "$PWD/git/contrib/diff-highlight/diff-highlight" "$HOME/bin/"

# git公式による補完設定
mkdir -p $HOME/.zsh/completions
wget -q -O $HOME/.zsh/completions/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
wget -q -O $HOME/.zsh/completions/_git https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh

autoload -U compinit
rm -f $HOME/.zcompdump; compinit
echo "[NOTICE] Please restart shell to apply completion for git"
