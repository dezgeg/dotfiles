alias tree='tree -C'
alias ls='ls -F --color=auto'

alias ps='ps u'
alias psu='ps ux'
alias psa='ps aux'
alias psgrep='pgrep -f'

alias grep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hd='hexdump -C'

if [ "$(uname)" = 'Linux' ]; then
    alias make="make -j$(( $(nproc) + 1))"
fi
alias maker='d=$(git rev-parse --show-toplevel) && make -C "$d"'

alias gdb='gdb -quiet'
alias tree='tree -C'

alias cdr='cd "$(git rev-parse --show-toplevel)"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gap='git add -p'
alias gcp='git commit -v'
alias gc!='git commit --amend -v'
alias gcp='git checkout -p'
alias gl='git log'
alias gri='git rebase -i'
alias gs='git status'
alias gsh='git show HEAD'
alias gsh^='git show HEAD^'
alias gsh^^='git show HEAD^^'

stty -ixon -ixoff
alias reset='\reset; stty -ixon -ixoff'

xrun() {
    # &! == put to background & disown (in Zsh only???)
    $1 >/dev/null 2>/dev/null </dev/null &!
}

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=-FRSX

if [ -e $HOME/.cargo/env ]; then source $HOME/.cargo/env; fi
if [ -e /home/tmtynkky/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tmtynkky/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:/sbin:/usr/sbin"
umask 0022
