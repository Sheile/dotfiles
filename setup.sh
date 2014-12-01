#!/bin/zsh

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
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/bundle

# NeoBundleへのリンク作成
ln -fs "$PWD/neobundle.vim" "$HOME/.vim/bundle/neobundle.vim"

# vim用のcolor schemeへのリンク作成
mkdir -p ~/.vim/colors
ln -fs "$PWD/desert256.vim/colors/desert256.vim" "$HOME/.vim/colors/desert256.vim"

# ~/binを作成して必要なスクリプトを配置
mkdir ~/bin
ln -fs "$PWD/git/contrib/diff-highlight/diff-highlight" "$HOME/bin/"

# zshによるgit関連の補完設定
mkdir -p ~/.zsh/completion
wget -q -O ~/.zsh/completion/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
wget -q -O ~/.zsh/completion/_git https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
autoload -U compinit
rm -f ~/.zcompdump; compinit
echo "[NOTICE] Please restart shell to apply completion for git"
