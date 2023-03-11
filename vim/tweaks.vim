" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Don't yank replaced text when pasting in visual mode
vnoremap p "_dP

" Do not touch the clipboard
noremap x "_x
noremap X "_X
noremap <Del> "_x
noremap <BS> "_X

" https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left
" TODO: try out another solution from:
" https://stackoverflow.com/questions/2295410/how-to-prevent-the-cursor-from-moving-back-one-character-on-leaving-insert-mode
let CursorColumnI = 0
autocmd VimRC InsertEnter * let CursorColumnI = col('.')
autocmd VimRC CursorMovedI * let CursorColumnI = col('.')
autocmd VimRC InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
