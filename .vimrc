syntax on
set hlsearch
set incsearch
set nocompatible
set autoindent
set backspace=indent,eol,start
set showcmd
if has('mouse')
	set mouse=a
endif
filetype plugin indent on

" Dvorak keybinds
no d h
no h j
no t k
no n l
no s :
no S :
no j d
no l n
no L N
no - $
no _ ^
no N <C-w><C-w>
no T <C-w><C-r>
no H 8<Down>
no T 8<Up>
no D <C-w><C-r>

set tabstop=4
set expandtab
set sw=4
set guifont=Monospace\ 7
set number

colorscheme elflord

set so=16
au BufRead,BufNewFile *.rb set expandtab
