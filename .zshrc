system_type=$(uname -s)
# Source misc.
ZSH_MISC_PATH="${HOME}/.config/zsh/misc.sh" 
if [[ -e ${ZSH_MISC_PATH} ]]; then
  source ${ZSH_MISC_PATH}
fi

# Source dir_colors.
ZSH_DIRCOLORS_PATH="${HOME}/.config/zsh/.dircolors" 
if [ "${system_type}" = "Darwin" ]; then
  test -r ${ZSH_DIRCOLORS_PATH} && eval $(gdircolors ${ZSH_DIRCOLORS_PATH})
else
  test -r ${ZSH_DIRCOLORS_PATH} && eval $(dircolors -b ${ZSH_DIRCOLORS_PATH})
fi

# Source aliases:
ZSH_ALIASES_PATH="${HOME}/.config/zsh/aliases.zsh" 
if [[ -e ${ZSH_ALIASES_PATH} ]]; then
  source ${ZSH_ALIASES_PATH}
fi

# Source plugins.
ZSH_PLUGINS_PATH="${HOME}/.config/zsh/plugins.zsh" 
if [[ -e ${ZSH_PLUGINS_PATH} ]]; then
  source ${ZSH_PLUGINS_PATH}
fi

# Source main configuration.
ZSH_MAIN_PATH="${HOME}/.config/zsh/main.zsh" 
if [[ -e ${ZSH_MAIN_PATH} ]]; then
  source ${ZSH_MAIN_PATH}
fi

# Zsh-Syntax-Highlighting, this must be sourced last.
# ZSH_SYNTAX_HIGHLIGHTING_DIR="${HOME}/.config/zsh/zsh-syntax-highlighting"
# if [ ! -d ${ZSH_SYNTAX_HIGHLIGHTING_DIR} ]; then
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
#     ${ZSH_SYNTAX_HIGHLIGHTING_DIR}
# fi
# 
# ZSH_SYNTAX_HIGHLIGHTING_PATH="${ZSH_SYNTAX_HIGHLIGHTING_DIR}/zsh-syntax-highlighting.zsh"
# if [[ -e ${ZSH_SYNTAX_HIGHLIGHTING_PATH} ]]; then
#   source ${ZSH_SYNTAX_HIGHLIGHTING_PATH}
# fi
