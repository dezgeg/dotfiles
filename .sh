# Global setup
export PATH="$HOME/bin:$HOME/.local/bin:$PATH:/sbin:/usr/sbin"
umask 0022
stty -ixon -ixoff

export EDITOR=vim
export VISUAL=$EDITOR
export LESS=-FRSX

# Aliases for setting sane defaults to commands
alias reset='\reset; stty -ixon -ixoff'

alias grep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls -F --color=auto'
alias tree='tree -C'

# cd aliases (do I actually use them)?
alias cdr='cd "$(git rev-parse --show-toplevel)"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'

# Git aliases
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

# Other random aliases
alias hd='hexdump -C'
alias make="make -j$(( $(nproc) + 1))"
alias maker='d=$(git rev-parse --show-toplevel) && make -C "$d"'

# Vim
alias nt="nvim-qt +terminal"

xrun() {
    # &! == put to background & disown (in Zsh only???)
    $1 >/dev/null 2>/dev/null </dev/null &!
}

# Shell init scripts for other programs
if [ -e $HOME/.cargo/env ]; then source $HOME/.cargo/env; fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then source $HOME/.nix-profile/etc/profile.d/nix.sh; fi
