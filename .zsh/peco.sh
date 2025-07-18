# pecoを使ったtmux window選択（現在のセッション内）
function peco-tmux-window() {
  local selected_window=$(tmux list-windows -F "#{window_index}:#{window_name}" | peco --query "$LBUFFER" | cut -d: -f1)
  if [ -n "$selected_window" ]; then
    tmux select-window -t "$selected_window"
  fi
}
zle -N peco-tmux-window
bindkey '^tw' peco-tmux-window

# pecoを使ったtmux window選択（全セッション）
function peco-tmux-window-all() {
  local selected_window=$(tmux list-windows -a -F "#{session_name}:#{window_index}:#{window_name}" | peco --query "$LBUFFER" | cut -d: -f1,2)
  if [ -n "$selected_window" ]; then
    tmux switch-client -t "$selected_window"
  fi
}
zle -N peco-tmux-window-all
bindkey '^t ' peco-tmux-window-all
