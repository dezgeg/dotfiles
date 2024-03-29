# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable '**' glob
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if which lesspipe >/dev/null 2>&1; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# enable color support of ls and also add handy aliases
if which dircolors >/dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Tediously hand-crafted prompt
_update_prompt() {
    local repo_info=$(git rev-parse --git-dir --abbrev-ref HEAD 2>/dev/null)
    local git_prompt=''
    if [ -n "$repo_info" ]; then
        local git_dir="${repo_info%$'\n'*}"
        local git_branch="${repo_info##*$'\n'}"
        git_prompt+='\[\033[0;33m\]' # yellow
        git_prompt+="($git_branch"
        if [ -d "$git_dir/rebase-merge" ]; then
            git_prompt+='®'
        fi
        if [ -f "$git_dir/CHERRY_PICK_HEAD" ]; then
            git_prompt+='©'
        fi
        if [ -f "$git_dir/rebase-apply" ]; then
            git_prompt+='α'
        fi
        if [ -f "$git_dir/BISECT_LOG" ]; then
            git_prompt+='β'
        fi
        git_prompt+=")"
    fi

    export PS1="$_ps1$git_prompt$_ps1_trailer"

    # Magic stuff to tell when command output did not end with newline
    local no_nl_1='\033[7m%%\033[m' # Reverse-video percent sign
    local no_nl_2='\r\033[K' # Move to start of line & erase
    printf "$no_nl_1%*s$no_nl_2" $((COLUMNS - 1)) ""
}

_ps1='\[\033[1;37m\]' # bold white
_ps1+='┊'
if [ -n "$SSH_CONNECTION" ] || [ -e /.dockerenv ]; then
    _ps1+='\[\e];\u@\h \w\a\]'  # window title = user@host directory
    _ps1+='\[\033[1;32m\]'     # bold green
    _ps1+='\u'                 # username
    _ps1+='\[\033[1;37m\]'     # bold white
    _ps1+='@'
    _ps1+='\[\033[1;36m\]'     # bold cyan
    _ps1+='\h'                 # hostname
    _ps1+=' '
else
    _ps1+='\[\e];\w\a\]' # window title = directory
fi
_ps1+='\[\033[1;34m\]' # bold blue
_ps1+='\w'             # directory
# Stuff after git status
_ps1_trailer=''
if [ "$USER" = root ]; then
    _ps1_trailer+='\[\033[1;31m\]' # bold red
    _ps1_trailer+='# '
else
    _ps1_trailer+='\[\033[1;35m\]' # bold orange
    _ps1_trailer+='$ '
fi
_ps1_trailer+='\[\033[00m\]'   # restore color

PROMPT_COMMAND=_update_prompt
_update_prompt

. ~/.sh

# Bash-specific shell init scripts for other programs
if [ -e $HOME/.fzf.bash ]; then source $HOME/.fzf.bash; fi
