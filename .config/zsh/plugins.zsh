PATH_ANTIGEN="${HOME}/.config/zsh/antigen.zsh"
if [ ! -f ${PATH_ANTIGEN} ]; then
      curl -L git.io/antigen > ${PATH_ANTIGEN}
fi

ADOTDIR="${HOME}/.config/zsh/antigen"
source ${PATH_ANTIGEN}

# == zsh-users Plugins ==
# Autosuggestions.
antigen bundle zsh-users/zsh-autosuggestions
# Extended completions.
antigen bundle zsh-users/zsh-completions
# Syntax highlighting.
antigen bundle zsh-users/zsh-syntax-highlighting
# ==  ==

# I'm done...
antigen apply
