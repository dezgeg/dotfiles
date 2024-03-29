augroup VimRC
    autocmd!
augroup END

" Colorscheme
source ~/dotfiles/vim/vundle-plugins.vim
source ~/dotfiles/vim/colorscheme.vim
source ~/dotfiles/vim/binds-dvorak.vim
source ~/dotfiles/vim/binds-misc.vim
source ~/dotfiles/vim/global-settings.vim

source ~/dotfiles/vim/lightline.vim
source ~/dotfiles/vim/terminal.vim
source ~/dotfiles/vim/tweaks.vim

source ~/dotfiles/vim/smart-paren.vim
source ~/dotfiles/vim/smart-window-close.vim
source ~/dotfiles/vim/nerdcommenter.vim

" Various global options
set formatoptions+=n " Do not make mess of numbered lists when using gq

" Various editing options
set copyindent " Autoindent?

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

" Sane paste
inoremap <C-p> <C-g>u<C-r>"
cnoremap <C-p> <C-g>u<C-r>"

" Undo
inoremap <C-u> <C-o>u
cnoremap <C-u> <C-o>u

" Repeat command for each line in selection
xnoremap <silent> . :normal .<CR>

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

" fzf
" Use --hidden with rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
noremap <C-E> :Files<CR>
noremap <C-G> :Rg<CR>
noremap <C-F> :Buffers<CR>
" Make ESC cancel (override global Esc map)
autocmd VimRC FileType fzf tnoremap <buffer> <Esc> <Esc>
let g:fzf_history_dir = '~/.local/share/fzf-history'

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

if exists("g:neovide")
    source ~/dotfiles/vim/neovide.vim
endif

" TODO:
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" http://vimcasts.org/episodes/undo-branching-and-gundo-vim/
" http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
