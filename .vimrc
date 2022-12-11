" Vundle
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    !mkdir -p ~/.vim/bundle
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:bootstrap=1
endif
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if !has('nvim')
  Plugin 'noahfrederick/vim-neovim-defaults'
endif
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'
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
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/argtextobj.vim'
call vundle#end()
filetype plugin indent on

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

augroup VimRC
    autocmd!
augroup END

" Colorscheme
source ~/dotfiles/vim/colorscheme.vim
source ~/dotfiles/vim/binds-dvorak.vim
source ~/dotfiles/vim/binds-misc.vim
source ~/dotfiles/vim/global-settings.vim

source ~/dotfiles/vim/lightline.vim
source ~/dotfiles/vim/terminal.vim
source ~/dotfiles/vim/tweaks.vim

source ~/dotfiles/vim/smart-paren.vim

" Appearance
set guicursor=n-v-c-sm:block-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=i-ci-ve:ver25-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=r-cr-o:hor20-blinkon1000-blinkoff100-blinkwait1000

source ~/.ideavimrc

" Various global options
set formatoptions+=n " Do not make mess of numbered lists when using gq

" Various editing options
set copyindent " Autoindent?

set mouse=a

set timeoutlen=100
set updatetime=200
" set clipboard=unnamed,autoselect

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
nnoremap <silent> <C-=> :tabnew \| Startify<CR>
nnoremap <C-Left> gT
nnoremap <C-Right> gt

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

" Undotree
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

function! g:Undotree_CustomMap()
    nmap <buffer> H <plug>UndotreePreviousState
    nmap <buffer> T <plug>UndotreeNextState
endfunction

noremap <silent> <C-u> :UndotreeToggle<CR>

" Startify
let g:startify_custom_header = []
let g:startify_commands = [
\   {"s": ["Shell", "terminal"]},
\   {"r": ["Reload .vimrc", "source $HOME/.vimrc"]},
\]

" fzf
" Use --hidden with rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
noremap <C-E> :Files<CR>
noremap <C-G> :Rg<CR>
noremap <C-F> :Buffers<CR>
" Make ESC cancel (override global Esc map)
autocmd VimRC FileType fzf tnoremap <buffer> <Esc> <Esc>
let g:fzf_history_dir = '~/.local/share/fzf-history'

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

" Smart terminal goto
function s:SmartTerminalGoto()
    if &buftype != "terminal"
        return
    endif

    let line = getline(".")

    " Match ls -la output, e.g.
    " -rw-r--r--   1 tmtynkky tmtynkky 10508 la 2020-09-12 20:59:07 .vimrc
    let LS_PATTERN = '^[-drwx]\{10\} \+\d \+\w\+ \+\w\+ \+[0-9.KM]\+ \+\w\+ \+\d\{4}-\d\d-\d\d \d\d:\d\d:\d\d \(.\+\)[/*|]\{0,1\}$'
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

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDAltDelims_c = 1
let g:NERDDefaultAlign = 'left'
noremap  <silent> <C-_> :call NERDComment('ci', 'toggle')<CR>
inoremap <silent> <C-_> <C-o>:call NERDComment('ci', 'toggle')<CR>

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
autocmd VimRC BufReadPost *
  \ if match(&ft, 'git\(commit\|rebase\)') < 0 && line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

" https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left
let CursorColumnI = 0
autocmd VimRC InsertEnter * let CursorColumnI = col('.')
autocmd VimRC CursorMovedI * let CursorColumnI = col('.')
autocmd VimRC InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" TODO:
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" http://vimcasts.org/episodes/undo-branching-and-gundo-vim/
" http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
" https://stevelosh.com/blog/2010/09/coming-home-to-vim/
