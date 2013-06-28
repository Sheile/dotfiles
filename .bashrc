# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export TZ=Asia/Tokyo
export LANG=ja_JP.utf8
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

export HISTSIZE=10000
export HISTCONTROL=ignoredups
export GREP_OPTIONS='--color=auto'

alias vi='vim'
alias view='vim -R'
alias irb='pry'
alias crontab='crontab -i'
alias jq='jq . -C'
alias less='less -R'
alias sudo='sudo -E '

shopt -s checkjobs
