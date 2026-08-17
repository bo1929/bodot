system_type=$(uname -s)
export PATH="${HOME}/.local/bin:$PATH"
# export SHELL="/bin/zsh"
# export SHELL="/usr/bin/zsh"
if command -v vim >/dev/null 2>&1; then
  export EDITOR="$(command -v vim)"
fi
if [ "${system_type}" = "Darwin" ]; then
  export PAGER="/usr/bin/less"
  export OPENER="open"
else
  export PAGER="/bin/less"
  export OPENER="xdg-open"
fi

case "${TERM}" in alacritty|alacritty-direct)
    if [ -n "${TMUX-}" ]; then
      export TERM=tmux-256color
    else
      export TERM=xterm-256color
    fi
    ;;
esac
export COLORTERM="${COLORTERM:-truecolor}"

export ZDOTDIR="$HOME/.config/zsh"
