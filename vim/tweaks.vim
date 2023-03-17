" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Don't yank replaced text when pasting in visual mode
vnoremap p "_dP

" Do not touch the clipboard
noremap x "_x
noremap X "_X
noremap <Del> "_x
noremap <BS> "_X

" Don't move the cursor when exiting insert mode
autocmd InsertLeave * :normal `^

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd VimRC BufReadPost *
  \ if match(&ft, 'git\(commit\|rebase\)') < 0 && line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif
