# pecoを使ったtmux window選択（現在のセッション内）
function peco-tmux-window() {
  local selected_window=$(tmux list-windows -F "#{window_index}:#{window_name}" | peco --query "$LBUFFER" | cut -d: -f1)
  if [ -n "$selected_window" ]; then
    tmux select-window -t "$selected_window"
  fi
}
zle -N peco-tmux-window
bindkey '^tw' peco-tmux-window
