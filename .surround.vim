" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .surround.vim
" Last Modified: 2017-07-23 18:34:38
" Vim: enc=utf-8

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

function s:saveMap(pat)
    let s:save=maparg(a:pat, 'i')
    " exec 'iunmap ' . a:pat if there is no map it will be error
    execute 'inoremap ' . a:pat . ' ' . a:pat
endfunction

function s:restoreMap(pat)
    execute 'inoremap ' . a:pat . ' ' . s:save
endfunction

function s:surround(num, pat)
    if a:pat !=# "'" && a:pat !=# '"' && a:pat !=# '{' &&
      \a:pat !=# '[' && a:pat !=# '(' && a:pat !=# '<'
        redraw
        echohl WarningMsg
            echo "   ❖  此字元不支援 ❖ "
        echohl NONE
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

function s:surroundNum(num)
    let pat = nr2char(getchar())
    call s:surround(a:num, pat)
endfunction

command -nargs=+ S call s:surround(<f-args>)
nnoremap <C-a> :<C-u>execute 'call ' v:count? '<SID>surroundNum(v:count)' : '<SID>surroundNum(1)'<CR>
