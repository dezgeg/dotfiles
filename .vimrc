" Vundle
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    !mkdir -p ~/.vim/bundle
    !git clone git://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:bootstrap=1
endif
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if !has('nvim')
  Plugin 'noahfrederick/vim-neovim-defaults'
endif
Plugin 'brooth/far.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'mbbill/undotree'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'svermeulen/vim-yoink'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
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
" let g:airline_theme = 'seoul256'
if has('nvim')
    let g:terminal_color_0  = '#606060'
    let g:terminal_color_1  = '#df9a98'
    let g:terminal_color_2  = '#719672'
    let g:terminal_color_3  = '#e0bb71'
    let g:terminal_color_4  = '#96bbdc'
    let g:terminal_color_5  = '#dfbdbc'
    let g:terminal_color_6  = '#97bcbc'
    let g:terminal_color_7  = '#d8d8d8'
    let g:terminal_color_8  = '#757575'
    let g:terminal_color_9  = '#e07798'
    let g:terminal_color_10 = '#97bb98'
    let g:terminal_color_11 = '#ffdd98'
    let g:terminal_color_12 = '#badcfb'
    let g:terminal_color_13 = '#ffbebc'
    let g:terminal_color_14 = '#96ddde'
    let g:terminal_color_15 = '#e9e9e9'
endif

" Appearance
set guicursor=n-v-c-sm:block-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=i-ci-ve:ver25-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=r-cr-o:hor20-blinkon1000-blinkoff100-blinkwait1000

source ~/.ideavimrc

" Various global options
set title " Set terminal window title
set shortmess+=atI " Do not show intro and shorten some messages
set matchpairs+=<:> " Allow using % on C++ template params
set splitbelow
set splitright
set scrolloff=16

" Tabs/spaces configuration
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Various editing options
set virtualedit=onemore " Allow moving to last column
set copyindent " Autoindent?
set autoindent " Language-specific smart indentation
set shiftround " Round indentation when using the << or >> commands

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
inoremap <A-d> <Left>
inoremap <A-h> <Down>
inoremap <A-t> <Up>
inoremap <A-n> <Right>
inoremap <A-b> <C-Left>
inoremap <A-w> <C-Right>
inoremap <A-^> <Home>
inoremap <A-$> <End>

" And command-line mode as well.
cnoremap <A-d> <Left>
cnoremap <A-h> <Down>
cnoremap <A-t> <Up>
cnoremap <A-n> <Right>
cnoremap <A-b> <C-Left>
cnoremap <A-w> <C-Right>
cnoremap <A-^> <Home>
cnoremap <A-$> <End>

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
" Make ESC cancel (override global Esc map)
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Smart window closing
function SmartWindowClose()
    if exists('w:terminal_buffer')
        let current_buffer = bufnr("%")
        setlocal bufhidden=delete
        execute "buffer " . w:terminal_buffer
        unlet w:terminal_buffer
        startinsert
    else
        if exists('g:GuiLoaded') && winnr("$") == 1 && tabpagenr("$") == 1
            echo "Not closing last window!"
        else
            q
        end
    endif
endfunction
nnoremap <silent> <C-Q> :call SmartWindowClose()<CR>

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    " Enter insert mode in terminals by default
    autocmd TermOpen * startinsert
    " Sync working directory every time insert mode is left
    function UpdateTerminalWorkingDirectory()
        " Extract PID from buffer name
        let matches = matchlist(expand('%'), '^term:\/\/.*\/\/\([0-9]\+\):')
        if len(matches) > 0
            let cwd = resolve('/proc/' . matches[1] . '/cwd')
            if isdirectory(cwd)
                execute 'cd ' . fnameescape(cwd)
            endif
        endif
    endfunction
    autocmd TermLeave * call UpdateTerminalWorkingDirectory()

    " Smart terminal goto
    function SmartTerminalGoto()
        if &buftype != "terminal"
            return
        endif

        let line = getline(".")
        let pattern = '^[-drwx]\{10\} \+\d \+\w\+ \+\w\+ \+\d\+ \+\w\+ \+\d\{4}-\d\d-\d\d \d\d:\d\d:\d\d \(.\+\)[/*|]\{0,1\}$'
        let matches = matchlist(line, pattern)
        if len(matches) > 0
            let file = matches[1]
            let w:terminal_buffer = bufnr('%')
            execute "edit " . file
        endif
    endfunction
    nnoremap <silent> <Return> :call SmartTerminalGoto()<CR>
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDAltDelims_c = 1
noremap  <silent> <C-_> :call NERDComment('ci', 'toggle')<CR>
inoremap <silent> <C-_> <C-o>:call NERDComment('ci', 'toggle')<CR>

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
