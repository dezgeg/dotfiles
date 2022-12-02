set noshowmode

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
