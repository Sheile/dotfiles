# Lines configured by zsh-newuser-install
setopt autocd
setopt auto_pushd

# 補完関連
unsetopt auto_menu

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
