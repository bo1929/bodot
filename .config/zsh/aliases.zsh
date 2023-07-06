# Colorize the ls output.
alias ls='\ls --color=auto'
# Use a long listing format.
alias ll='\ls -la'
# Show hidden files
alias lh='\ls -d .* --color=auto'
# Some more ls aliases.
alias ll='\ls -alF'
alias la='\ls -A'
alias l='\ls -CF'
# Make them colorful.
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# set TERM before ssh.
alias ssh='TERM=xterm-256color ssh'

# =====================

# Third-party applications.
alias ls='exa -snew'
