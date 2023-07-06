# Enable colors and change prompt.
autoload -U colors && colors
PS1="%B%{$fg[yellow]%}[%{$fg[blue]%}%n%{$fg[red]%}@%{$fg[green]%}%~%{$fg[yellow]%}]%{$reset_color%}$%b"
RPROMPT="%{$fg[yellow]%}[%D{%m/%f}|%T]%{$reset_color%}"

# The following lines were added by compinstall.
zstyle ':completion:*' completer _complete _ignored _correct
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true # "path//<Tab>" is "path/" rather than "path/*"
zstyle :compinstall filename ${HOME}'/.zshrc'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zmodload zsh/complist
autoload -Uz compinit
compinit
# End of lines added by compinstall.

# Lines configured by zsh-newuser-install.
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install.

# Beginning of vi mode.
# Use vim keys in tab complete menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
# Initiate `vi insert` as keymap
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}
# End of vi mode.

bindkey '^R' history-incremental-search-backward
