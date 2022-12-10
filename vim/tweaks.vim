" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Do not touch the clipboard
noremap x "_x
noremap X "_X
noremap <Del> "_x
noremap <BS> "_X
