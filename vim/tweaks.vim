" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Don't yank replaced text when pasting in visual mode
vnoremap p "_dP

" Re-select text when indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Do not touch the clipboard
noremap x "_x
noremap X "_X
noremap <Del> "_x
noremap <BS> "_X
