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
Plugin 'godlygeek/tabular'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/gv.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'mbbill/undotree'
Plugin 'mhinz/vim-startify'
" Plugin 'michaeljsmith/vim-indent-object' broken?
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'svermeulen/vim-yoink'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
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
set noshowmode " Unnecessary with lightline
set nojoinspaces " Better J behaviour
set formatoptions+=n " Do not make mess of numbered lists when using gq

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
set wildignore+=*.pdf,*.aux,*.toc,*.blg,*.bbl,*.cls
set wildmode=longest,list

set showcmd
set mouse=a

if has('nvim')
    set inccommand=nosplit
endif

function LightlineFilenameOrTermCwd()
    if exists('b:terminal_job_pid')
        return fnamemodify(resolve('/proc/' . b:terminal_job_pid . '/cwd'), ':~:.')
    else
        return expand('%:~:.')
    endif
endfunction

function LightlineReadonly()
    return &readonly ? 'RO' : ''
endfunction

let g:lightline = {
\    'colorscheme': 'seoul256',
\    'active': {
\       'left': [['mode', 'paste'], ['filename', 'modified', 'readonly']],
\       'right': [['lineinfo'], ['percent'], ['gitbranch']],
\    },
\    'component_function': {
\       'filename': 'LightlineFilenameOrTermCwd',
\       'gitbranch': 'FugitiveHead',
\    },
\    'component_expand': {
\       'readonly': 'LightlineReadonly',
\    },
\    'component_type': {
\       'readonly': 'error',
\    },
\}

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

" Indent changes in insert mode (does not work in terminal!)
inoremap <C-,> <C-D>
inoremap <C-.> <C-T>

" Remap autocomplete to more logical keys
inoremap <C-h> <C-n>
inoremap <C-t> <C-p>

" Sane paste
inoremap <C-p> <C-g>u<C-r>"
cnoremap <C-p> <C-g>u<C-r>"

" Undo
inoremap <C-u> <C-o>u
cnoremap <C-u> <C-o>u

" Repeat command for each line in selection
xnoremap <silent> . :normal .<CR>

" select pasted text
noremap gp `[v`]

" Tabs
nnoremap <silent> <C-=>  :tabnew<CR>
nnoremap <C-[>  gT
nnoremap <C-]>  gt

" Jumplist navigation: Ctrl-{Left,Right), Alt-[dn]
nnoremap <M-Left>  <C-o>
nnoremap <M-Right> <C-i>
vnoremap <M-Left>  <C-o>
vnoremap <M-Right> <C-i>
nnoremap <M-d> <C-o>
nnoremap <M-n> <C-i>
vnoremap <M-d> <C-o>
vnoremap <M-n> <C-i>

" Git
noremap gs :Gstatus<CR>
noremap gd :Gdiff<CR>

" fzf
" Use --hidden with rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
noremap <C-E> :Files<CR>
noremap <C-G> :Rg<CR>
noremap <C-F> :Buffers<CR>
" Make ESC cancel (override global Esc map)
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" If closing an editor window opened from terminal, focus back that same terminal
function s:SmartWindowClose()
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
nnoremap <silent> <C-Q> :call <SID>SmartWindowClose()<CR>

" In diff mode, go to next/previous diff hunk
" In terminal mode, go to next/previous prompt occurrence
function s:SmartParen(key, mode)
    if a:mode == 'v'
        normal! gv
    endif

    if &diff
        if a:key == '('
            normal! [c
        else
            normal! ]c
        endif
        return
    endif

    if &buftype != "terminal"
        if a:key == '('
            normal! (
        else
            normal! )
        endif
        return
    endif

    let flags = 'nW'
    if a:key == '('
        let flags ..= 'b'
    endif
    let lineno = search('^┊', flags)

    if lineno != 0
        call cursor(lineno, 1)
    endif
endfunction
nnoremap <silent> ( :call <SID>SmartParen('(', 'n')<CR>
nnoremap <silent> ) :call <SID>SmartParen(')', 'n')<CR>
vnoremap <silent> ( :call <SID>SmartParen('(', 'v')<CR>
vnoremap <silent> ) :call <SID>SmartParen(')', 'v')<CR>

" u/U in visual mode to search for the current selection (mnemoic: use)
function! s:SearchForSelection(dir)
    let old = @"
    normal! gvy

    let regex = '\V' .. escape(@", '/\')

    let @" = old
    let @/ = regex
    execute 'normal! ' .. a:dir .. regex .. "\r"
endfunction

vnoremap u :call <SID>SearchForSelection('/')<CR>
vnoremap U :call <SID>SearchForSelection('?')<CR>

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    " Enter insert mode in terminals by default
    autocmd TermOpen * startinsert
    " Sync working directory every time insert mode is left
    function s:UpdateTerminalWorkingDirectory()
        if exists('b:terminal_job_pid')
            let cwd = resolve('/proc/' . b:terminal_job_pid . '/cwd')
            if isdirectory(cwd)
                execute 'cd ' . fnameescape(cwd)
            endif
        endif
    endfunction
    autocmd TermLeave * call <SID>UpdateTerminalWorkingDirectory()

    " Smart terminal goto
    function s:SmartTerminalGoto()
        if &buftype != "terminal"
            return
        endif

        let line = getline(".")

        " Match ls -la output, e.g.
        " -rw-r--r--   1 tmtynkky tmtynkky 10508 la 2020-09-12 20:59:07 .vimrc
        let LS_PATTERN = '^[-drwx]\{10\} \+\d \+\w\+ \+\w\+ \+\d\+ \+\w\+ \+\d\{4}-\d\d-\d\d \d\d:\d\d:\d\d \(.\+\)[/*|]\{0,1\}$'
        let matches = matchlist(line, LS_PATTERN)
        if len(matches) > 0
            let file = matches[1]
            let w:terminal_buffer = bufnr('%')
            execute "edit " . file
            return
        endif

        " Match grep -n output, e.g.:
        " .vimrc:272:    function s:SmartTerminalGoto()
        let GREP_PATTERN = '^\([^:]\+\):\([0-9]\+\)'
        let matches = matchlist(line, GREP_PATTERN)
        if len(matches) > 0
            let file = matches[1]
            let lineno = matches[2]
            let w:terminal_buffer = bufnr('%')
            execute "edit +" . lineno . " " . file
            return
        endif

        " Match rg output when on a line number, e.g. second line:
        " .vimrc
        " 272:    function s:SmartTerminalGoto()
        let RG_PATTERN = '^\([0-9]\+\):'
        let matches = matchlist(line, RG_PATTERN)
        if len(matches) > 0
            let lineno = matches[1]

            " Scan upwards (up to 100 lines) to find the filename to edit
            let term_line = line(".") - 1
            let stop_line = min([term_line - 100, 1])
            while term_line >= stop_line
                let line = getline(term_line)
                let matches = matchlist(line, RG_PATTERN)
                if len(matches) == 0
                    " 'line' did not contain line number -> should be filename
                    if filereadable(line)
                        let w:terminal_buffer = bufnr('%')
                        execute "edit +" . lineno . " " . line
                    endif
                    return
                endif

                let term_line -= 1
            endwhile

        endif

    endfunction
    nnoremap <silent> <Return> :call <SID>SmartTerminalGoto()<CR>
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDAltDelims_c = 1
noremap  <silent> <C-_> :call NERDComment('ci', 'toggle')<CR>
inoremap <silent> <C-_> <C-o>:call NERDComment('ci', 'toggle')<CR>

" Yoink
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
let g:yoinkMaxItems = 30
let g:yoinkMoveCursorToEndOfPaste = 1
if has('nvim')
    let g:yoinkSavePersistently = 1
endif

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
