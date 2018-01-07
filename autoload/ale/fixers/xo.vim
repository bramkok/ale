" Author: bramkok (Bram Kok) <bramkok.com>,
" Description: Integration of xo with ALE.

call ale#Set('javascript_xo_executable', 'xo')
call ale#Set('javascript_xo_use_global', 0)
call ale#Set('javascript_xo_options', '')

function! ale#fixers#xo#GetExecutable(buffer) abort
    return ale#node#FindExecutable(a:buffer, 'javascript_xo', [
    \ 'node_modules/.bin/xo',
    \])
endfunction

function! ale#fixers#xo#Fix(buffer) abort
    let l:executable = ale#fixers#xo#GetExecutable(a:buffer)
    let l:options = ale#Var(a:buffer, 'javascript_xo_options')

    return {
    \   'command': ale#path#BufferCdString(a:buffer)
    \       . ale#Escape(l:executable)
    \       . (!empty(l:options) ? ' ' . l:options : '')
    \       . ' --fix --stdin',
    \}
endfunction
