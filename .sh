function normalize_command_line () {
    # Declaring a function resolves all aliases in the body.
    eval "function _f() {
        $1
    }"
    declare -f _f | head -n -1 | tail -n -1
    unset -f _f
}

function lessalias() {
    # Use this instead of 'alias ll="ls | less"', so 'll foo*' works as well.
    alias $1="lesswrap $(normalize_command_line $2)"
}

alias tree='tree -C'
alias ls='ls -F --color=auto'
alias la='ls -lah'
alias latr='ls -latr'

alias l=la
lessalias ll 'la --color'

alias ps='ps u'
alias psu='ps ux'
alias psa='ps aux'
alias psgrep='pgrep -f'

lessalias psul psu
lessalias psal psa

alias grep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias halt='poweroff'
alias hd='hexdump -C'
alias make="make -j$((`cat /proc/cpuinfo | egrep '^processor' -c` + 1))"
alias maker='d=$(git rev-parse --show-toplevel) && make -C "$d"'

lessalias treel 'tree -C'
lessalias makel 'make -j1'

alias cdr='d=$(git rev-parse --show-toplevel) && cd "$d"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

stty -ixon -ixoff
alias reset='\reset; stty -ixon -ixoff'

setproc() {
    echo $2 | sudo tee $1 >/dev/null
}

reload () {
    exec "${SHELL}" "$@"
}

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
