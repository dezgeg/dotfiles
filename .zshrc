export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="dpoggi"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git dirhistory)

source $ZSH/oh-my-zsh.sh
. ~/.sh

function up() {
    zle kill-buffer
    cd ..
    zle accept-line
}

# Alt-Up goes to parent dir
zle -N up
bindkey "\e[3A"     up
bindkey "\e[1;3A"   up
bindkey "\e\e[A"    up # Putty
bindkey "\eO3A"     up # GNU screen

# Alt-Down undoes
bindkey "\e[3B"     dirhistory_zle_dirhistory_back
bindkey "\e[1;3B"   dirhistory_zle_dirhistory_back
bindkey "\e\e[B"    dirhistory_zle_dirhistory_back # Putty
bindkey "\eO3B"     dirhistory_zle_dirhistory_back # GNU screen

alias -g E='2>&1'
alias -g G='| grep'
alias -g H='| head'
alias -g L='2>&1 | less'
alias -g N='&>/dev/null'
alias -g T='| tail'

setopt   glob_complete      # Tab on 'ls foo*' gives completion choices for foo*
setopt   list_packed        # More compact completion list columns
unsetopt auto_menu          # More bash-style completion

# Customized prompt based on dpoggi
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="cyan"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%j %{$fg[$NCOLOR]%}%m\
%{$reset_color%} %{$fg[green]%}%~\
 $(git_prompt_info)\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code} %{$fg[yellow]%}%D{%H:%M:%S}%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX "
