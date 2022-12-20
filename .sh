# Global setup
export PATH="$HOME/bin:$HOME/.local/bin:$PATH:/sbin:/usr/sbin"
umask 0022
stty -ixon -ixoff

export EDITOR=v
export VISUAL=$EDITOR

export LESS=-FRSX
export FZF_DEFAULT_OPTS='-e --bind=alt-h:down,alt-t:up'
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Aliases for setting sane defaults to commands
alias reset='\reset; stty -ixon -ixoff'

alias grep='grep -P --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls -F --color=auto --time-style="+%a %Y-%m-%d %H:%M:%S"'
alias tree='tree -C'
# Smart case, include dot files/dirs, sane maximum line length
alias rg='rg -S --hidden -M 140 --max-columns-preview'

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
alias gc='git commit -v'
alias gc!='git commit --amend -v'
alias gcp='git checkout -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gri='git rebase -i'
alias gs='git status'
alias gsh='git show HEAD'
alias gsh^='git show HEAD^'
alias gsh^^='git show HEAD^^'

# Other random aliases
alias hd='hexdump -C'
alias make="make -j$(( $(nproc) + 1))"
alias maker='make -C "$(git rev-parse --show-toplevel)"'

# Vim
alias vim=v
alias nt="nvim-qt +terminal"
vg() {
    local files=$(git grep -El "$@")
    if [ $? != 0 ]; then
        return
    fi
    if [ "$files" != "" ]; then
        vim $files
    else
        echo "No files!"
    fi
}

xrun() {
    # &! == put to background & disown (in Zsh only???)
    $1 >/dev/null 2>/dev/null </dev/null &!
}

# Shell init scripts for other programs
if [ -e $HOME/.cargo/env ]; then source $HOME/.cargo/env; fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then source $HOME/.nix-profile/etc/profile.d/nix.sh; fi
