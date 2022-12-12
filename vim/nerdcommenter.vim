let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDAltDelims_c = 1
let g:NERDDefaultAlign = 'left'
noremap  <silent> <C-_> :call nerdcommenter#Comment('ci', 'toggle')<CR>
inoremap <silent> <C-_> <C-o>:call nerdcommenter#Comment('ci', 'toggle')<CR>
