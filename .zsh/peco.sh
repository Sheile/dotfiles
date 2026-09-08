# pecoを使ったコマンド履歴からの実行
function peco-execute-history() {
  local command=$(history -n -r 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\\\n/\\\n/g')
  if [ "$command" != "" ]; then
    BUFFER=$command
    zle accept-line
    zle -R -c
  fi
}
zle -N peco-execute-history
bindkey '^r' peco-execute-history


# pecoを使ったコマンド履歴からの呼び出し（実行しない）
function peco-select-history() {
  local command=$(history -n -r 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\\\n/\\\n/g')
  if [ "$command" != "" ]; then
    BUFFER=$command
    CURSOR=${#BUFFER}
    zle -R -c
  fi
}
zle -N peco-select-history
bindkey '^ip' peco-select-history
bindkey '^i^p' peco-select-history


# pecoを使ったプロセスkill（実行しない）
function peco-kill-process() {
  local processes=$(
    ps -u $USER -o pid,stat,%cpu,%mem,cputime,command \
      | peco \
      | awk '{print $1}' \
      | tr '\n' ' ' \
      | sed 's/^PID //' \
      | sed -z 's/ $//'
  )
  if [ "$processes" != "" ]; then
    BUFFER="kill $processes"
    CURSOR=${#BUFFER}
    zle -R -c
  fi
}
zle -N peco-kill-process
bindkey '^ik' peco-kill-process
bindkey '^i^k' peco-kill-process


# pecoを使ったtmux window選択（現在のセッション内）
function peco-tmux-window() {
  local selected_window=$(tmux list-windows -F "#{window_index}:#{window_name}" | peco --query "$LBUFFER" | cut -d: -f1)
  if [ -n "$selected_window" ]; then
    tmux select-window -t "$selected_window"
  fi
}
zle -N peco-tmux-window
bindkey '^tw' peco-tmux-window


# pecoを使ったディレクトリ移動
function peco-cdr() {
  local path=$(cdr -l | sed -E 's/^[0-9]+[[:space:]]+//' | peco --query "$LBUFFER")
  if [ "$path" != "" ]; then
    BUFFER="cd $path"
    zle accept-line
    zle -R -c
  fi
}
zle -N peco-cdr
bindkey '^if' peco-cdr
bindkey '^i^f' peco-cdr


# pecoを使ったdockerコンテナ削除
function peco-remove-container() {
  local containers=$(
    docker ps -a \
      | peco \
      | awk '{print $1}' \
      | tr '\n' ' ' \
      | sed -z 's/ $//'
  )
  if [ "$containers" != "" ]; then
    echo $containers
    BUFFER="docker rm $containers"
    CURSOR=${#BUFFER}
    zle -R -c
  fi
}
zle -N peco-remove-container
alias rmc=peco-remove-container
