" If closing an editor window opened from terminal, focus back that same terminal
function s:SmartWindowClose()
    if exists('w:terminal_buffer')
        let current_buffer = bufnr("%")
        setlocal bufhidden=delete
        execute "buffer " . w:terminal_buffer
        unlet w:terminal_buffer
        startinsert
    else
        if exists('b:terminal_job_pid')
            echo "Not closing terminal window!"
        elseif exists('g:GuiLoaded') && winnr("$") == 1 && tabpagenr("$") == 1
            echo "Not closing last window!"
        else
            q
        end
    endif
endfunction
nnoremap <silent> <C-Q> :call <SID>SmartWindowClose()<CR>
