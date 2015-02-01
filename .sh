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

alias gdb='gdb -quiet'
alias tree='tree -C'
lessalias treel 'tree -C'
lessalias makel 'make -j1'

alias cdr='d=$(git rev-parse --show-toplevel) && cd "$d"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias git=hub
alias gcp='git checkout -p'
alias gl='git log'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gri='git rebase -i'
alias gs='git status'
alias gsh='git show HEAD'
unalias gsd 2>/dev/null

stty -ixon -ixoff
alias reset='\reset; stty -ixon -ixoff'

setproc() {
    echo $2 | sudo tee $1 >/dev/null
}

reload() {
    exec "${SHELL}" "$@"
}

xrun() {
    # &! == put to background & disown (in Zsh only???)
    $1 >/dev/null 2>/dev/null </dev/null &!
}

alias clion='xrun ~/opt/clion-140.1221.2/bin/clion.sh'
alias idea='xrun ~/opt/idea-IU-139.224.1/bin/idea.sh'
alias pycharm='xrun ~/opt/pycharm-4.0/bin/pycharm.sh'
alias rubymine='xrun ~/opt/RubyMine-7.0/bin/rubymine.sh'

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=-FRSX
export NNTPSERVER=news.gmane.org
export QT_STYLE_OVERRIDE=plastique
export JAVA_HOME=/usr/lib/jvm/java-8-jdk

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:/sbin:/usr/sbin"
