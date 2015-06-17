bindkey -e

setopt ignore_eof
setopt interactive_comments

# cd関連
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
alias b='cd ..'

# 補完関連
unsetopt auto_menu

fpath=(~/.zsh/zsh-completions/src ~/.zsh/completions $fpath)
autoload -Uz compinit
compinit -u

# Environment variables
export TZ=Asia/Tokyo
export LANG=ja_JP.utf8
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

export GREP_OPTIONS='--color=auto'
export PATH=$HOME/bin:$PATH

# Aliases
alias vi='vim'
alias view='vim -R'
alias irb='pry'
alias crontab='crontab -i'
alias less='less -R'
alias la='ls -la'
alias diff='colordiff -u'

# show filelist when change directory.
chpwd() {
  ll
}

# <C-s>/<C-q>による画面更新の停止機能を無効化
stty stop undef
stty start undef

# history settings
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt hist_no_store
setopt hist_expand

# 入力中の内容にマッチする物のみ履歴をたどる
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# 空Enterでgit status表示
function do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo

  # ls
  # ↓おすすめ
  # ls_abbrev

  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
      echo
      git status -sb
  fi
  zle reset-prompt
  return 0
}
zle -N do_enter
bindkey '^m' do_enter

# promptにgitのbranchとstatusを表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}
PROMPT="[%n@%m]%~ %2F%1v%f%(!,#,%%) "

# Display root node when run the jq without argument
function jq() {
  if [ ! -p /dev/stdin ]; then
    return $(command jq)
  fi

  if [ -z "$1" ]; then
    cat - | command jq -C .
  else
    cat - | command jq -C $1
  fi
}
