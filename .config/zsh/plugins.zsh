PATH_ANTIGEN="${HOME}/.config/zsh/antigen.zsh"
if [ ! -f ${PATH_ANTIGEN} ]; then
      curl -L git.io/antigen > ${PATH_ANTIGEN}
fi

ADOTDIR="${HOME}/.config/zsh/antigen"
source ${PATH_ANTIGEN}

# == zsh-users Plugins ==
# Autosuggestions.
# On remote hosts LC_THEME (passed by the local ssh wrapper) is the hint.
case "${LC_THEME:-$(grep -o '[^"/]*\.toml' "${HOME}/.config/theme/colorschemes.toml" 2>/dev/null | tail -1)}" in
  *light*) ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#bdae93' ;;
  *)       ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#665c54' ;;
esac
antigen bundle zsh-users/zsh-autosuggestions
# Extended completions.
antigen bundle zsh-users/zsh-completions
# Syntax highlighting.
antigen bundle zsh-users/zsh-syntax-highlighting
# ==  ==

# I'm done...
antigen apply
