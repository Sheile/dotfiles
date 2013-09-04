# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
setopt auto_pushd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ec2-user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Environment variables
export TZ=Asia/Tokyo
export LANG=ja_JP.utf8
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

export HISTSIZE=10000
export HISTCONTROL=ignoredups
export GREP_OPTIONS='--color=auto'

# Aliases
alias vi='vim'
alias view='vim -R'
alias irb='pry'
alias crontab='crontab -i'
alias jq='jq . -C'
alias less='less -R'
alias la='ls -la'
alias b='cd ..'

# show filelist when change directory.
chpwd() {
  ll
}

# <C-s>/<C-q>による画面更新の停止機能を無効化
stty stop undef
stty start undef
