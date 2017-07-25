" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .surround.vim
" Last Modified: 2017-07-24 23:00:43
" Vim: enc=utf-8

let s:list=["'", '"', '(', '[', '{', '<']

function s:mapBrackets(pat)
    if a:pat ==# "'"
        return "'"
    elseif a:pat ==# '"'
        return '"'
    elseif a:pat ==# '{'
        return '}'
    elseif a:pat ==# '['
        return ']'
    elseif a:pat ==# '('
        return ')'
    elseif a:pat ==# '<'
        return '>'
    endif
endfunction

function s:checkBrackets(pat)
    for c in s:list
        if a:pat ==# c
            return 1
        endif
    endfor
    redraw
    echohl WarningMsg
        echo "   ❖  此字元不支援 ❖ "
    echohl NONE
    return 0
endfunction

function s:saveMap(pat)
    let s:save=maparg(a:pat, 'i')
    " exec 'iunmap ' . a:pat if there is no map it will be error
    execute 'inoremap ' . a:pat . ' ' . a:pat
endfunction

function s:restoreMap(pat)
    execute 'inoremap ' . a:pat . ' ' . s:save
endfunction

function s:surround(num, pat)
    if s:checkBrackets(a:pat) ==# 0
        return
    endif
    call s:saveMap(a:pat)
    execute "normal viw\<ESC> bi".a:pat
    for i in range(a:num)
        execute "normal e"
    endfor
    execute "normal a".s:mapBrackets(a:pat)
    call s:restoreMap(a:pat)
endfunction

function s:surroundNadd(num)
    let pat = nr2char(getchar())
    call s:surround(a:num, pat)
endfunction

function s:surroundNdel() " TODO 只有被包圍才刪除
    let pat = nr2char(getchar())
    if s:checkBrackets(pat) ==# 0
        return
    endif
    execute "normal F".pat."xf".s:mapBrackets(pat)."x"
endfunction

command -nargs=+ S call s:surround(<f-args>)
nnoremap <silent> <Plug>SurroundNadd :<C-u>execute 'call '
    \v:count? '<SID>surroundNadd(v:count)' : '<SID>surroundNadd(1)'<CR>
nmap <M-s> <Plug>SurroundNadd
nmap ys <M-s>

nnoremap <M-d> :<C-u>call <SID>surroundNdel()<CR>
nmap ds <M-d>
