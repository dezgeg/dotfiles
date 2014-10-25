export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="skaro"
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

alias -g L='2>&1 | less'
