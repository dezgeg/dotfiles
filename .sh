alias ls='ls -F --color=auto'
alias la='ls -lah'
alias latr='ls -latr'

alias grep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hd='hexdump -C'
alias make="make -j$((`cat /proc/cpuinfo | egrep '^processor' -c` + 1))"
alias maker='d=$(git rev-parse --show-toplevel) && make -C "$d"'

alias treel='tree -C | less'
alias makel='make -j1 2>&1 | less'

alias cdr='d=$(git rev-parse --show-toplevel) && cd "$d"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

stty -ixon -ixoff
alias reset='\reset; stty -ixon -ixoff'

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=-FRSX
export NNTPSERVER=news.gmane.org
export QT_STYLE_OVERRIDE=plastique

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/Qt/5.3/gcc_64/bin:$PATH"
export PATH="$PATH:/sbin:/usr/sbin"
