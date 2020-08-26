" Vundle
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    !mkdir -p ~/.vim/bundle
    !git clone git://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:bootstrap=1
endif
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if !has('nvim')
  Plugin 'noahfrederick/vim-neovim-defaults'
endif
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

" Colorscheme
set t_Co=256
set background=dark
let g:seoul256_background=233
colorscheme seoul256
if has('nvim')
    let g:terminal_color_0  = '#4e4e4e'
    let g:terminal_color_1  = '#d68787'
    let g:terminal_color_2  = '#5f865f'
    let g:terminal_color_3  = '#d8af5f'
    let g:terminal_color_4  = '#85add4'
    let g:terminal_color_5  = '#d7afaf'
    let g:terminal_color_6  = '#87afaf'
    let g:terminal_color_7  = '#d0d0d0'
    let g:terminal_color_8  = '#626262'
    let g:terminal_color_9  = '#d75f87'
    let g:terminal_color_10 = '#87af87'
    let g:terminal_color_11 = '#ffd787'
    let g:terminal_color_12 = '#add4fb'
    let g:terminal_color_13 = '#ffafaf'
    let g:terminal_color_14 = '#87d7d7'
    let g:terminal_color_15 = '#e4e4e4'
endif

source ~/.ideavimrc

" Various global options
set title " Set terminal window title
set shortmess+=atI " Do not show intro and shorten some messages
set ruler " Show line/column number (not really necessary with powerline though)
set matchpairs+=<:> " Allow using % on C++ template params
set splitbelow
set splitright
"set nobackup nowritebackup noswapfile  " defaults
"set hidden             " maybe later

" Tabs/spaces configuration
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Various editing options
set virtualedit=onemore " Allow moving to last column
set copyindent " Autoindent?
set smartindent " Language-specific smart indentation
set shiftround " Round indentation when using the << or >> commands

" Do these have effect if matchtime is 0?
set showmatch
set matchtime=0

set list listchars=tab:»·,trail:.
set wildignore+=*.a,*.o,*.d,*.out,*.beam,*.pyc
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn,deps,ebin
set wildignore+=*~,*.swp,*.tmp
set wildignore+=*.pdf,*.aux,*.toc,*.blg,*.bbl,*.cls,*.log
set wildmode=longest,list

set showcmd
if has('mouse')
    set mouse=a
endif

" Trailing whitespace - https://vim.fandom.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

set timeoutlen=100
set so=16
au BufRead,BufNewFile *.rb set expandtab
au BufRead,BufNewFile *.rb setlocal sw=2 ts=2 sts=2
set updatetime=200
" set clipboard=unnamed,autoselect

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Navigation in insert mode
" Alt-{dhtn, bw}: as usual
" Alt-{0^}: ^ and $
inoremap <Esc>d <Left>
inoremap <Esc>h <Down>
inoremap <Esc>t <Up>
inoremap <Esc>n <Right>
inoremap <Esc>b <C-Left>
inoremap <Esc>w <C-Right>
inoremap <Esc>^ <Home>
inoremap <Esc>$ <End>

" And command-line mode as well.
cnoremap <Esc>d <Left>
cnoremap <Esc>h <Down>
cnoremap <Esc>t <Up>
cnoremap <Esc>n <Right>
cnoremap <Esc>b <C-Left>
cnoremap <Esc>w <C-Right>
cnoremap <Esc>^ <Home>
cnoremap <Esc>$ <End>

" Ctrl-Backspace and Alt-Backspace
inoremap <Esc><Backspace> <C-W>
cnoremap <Esc><Backspace> <C-W>
inoremap <C-H> <C-W>
cnoremap <C-H> <C-W>

" Git
noremap gs :Gstatus<CR>
noremap gd :Gdiff<CR>

" fzf
noremap <C-E> :Files<CR>
noremap <C-G> :Ag<CR>

" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    " Enter insert mode in terminals by default
    autocmd TermOpen * startinsert
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDAltDelims_c = 1
noremap  <silent> <C-_> :call NERDComment('ci', 'toggle')<CR>
inoremap <silent> <C-_> <C-o>:call NERDComment('ci', 'toggle')<CR>

" NERDTree
let g:NERDTreeMapOpenInTab = '<Nop>'
let g:NERDTreeMapOpenInTabSilent = '<Nop>'
let g:NERDTreeMapOpenVSplit = '<Nop>'
let g:NERDTreeMapHelp = '<Nop>'

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
