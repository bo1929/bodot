system_type=$(uname -s)
if [ "${system_type}" = "Darwin" ]; then
  export PATH="${HOME}/.local/bin:$PATH"
  export SHELL="/bin/zsh"
  export EDITOR="/usr/local/bin/vim"
  export PAGER="/usr/bin/less"
else
  export SHELL="/usr/bin/zsh"
  export EDITOR="/bin/vim"
  export PAGER="/bin/less"
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
