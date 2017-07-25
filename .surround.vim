" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .surround.vim
" Last Modified: 2017-07-24 23:00:43
" Vim: enc=utf-8

let s:patlist=["'", '"', '(', '[', '{', '<']

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


function s:isBrackets(pat)
    for c in s:patlist
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


function s:isInSurround(pat)
    let nofound = 0
    let s:nowcol = col(".")
    execute "normal F".a:pat
    if matchstr(getline('.'), '\%' . col('.') . 'c.') !=# a:pat
        " https://stackoverflow.com/questions/23323747/vim-vimscript-get-exact-character-under-the-cursor
        let nofound = 1
    endif
    let leftcol=col(".")
    execute "normal f".s:mapBrackets(a:pat)
    if matchstr(getline('.'), '\%' . col('.') . 'c.') !=# s:mapBrackets(a:pat)
        let nofound = 1
    endif
    let rightcol=col(".")
    if nofound ==# 0 && leftcol <= s:nowcol && rightcol >= s:nowcol && leftcol !=# rightcol
        redraw
        echohl WarningMsg
           "  echo s:nowcol." ".leftcol." ".rightcol
            echo "   ❖  刪除".a:pat.s:mapBrackets(a:pat)." ❖ "
        echohl NONE
        return 1
    endif
    redraw
    echohl WarningMsg
        echo "   ❖  沒有在".a:pat.s:mapBrackets(a:pat)."裡喔 ❖ "
    echohl NONE
    " recover sorcur position
    execute "normal 0".(s:nowcol)."lh"
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
    if s:isBrackets(a:pat) ==# 0
        return
    endif
    call s:saveMap(a:pat)
    execute "normal viw\<ESC> bi".a:pat
    for i in range(a:num)
        execute "normal e"
    endfor
    execute "normal a".s:mapBrackets(a:pat)
    call s:restoreMap(a:pat)
    redraw
    echohl WarningMsg
        echo "   ❖  加入".a:pat.s:mapBrackets(a:pat)." ❖ "
    echohl NONE
endfunction


function s:surroundNadd(num)
    let pat = nr2char(getchar())
    call s:surround(a:num, pat)
endfunction


function s:surroundNdel()
    let pat = nr2char(getchar())
    " check is can delete
    if s:isBrackets(pat) ==# 0
        return
    endif
    if s:isInSurround(pat) ==# 0
        return
    endif
    " delete
    execute "normal F".pat."xf".s:mapBrackets(pat)."x"
    " recover sorcur position
    execute "normal 0".(s:nowcol)."lhh"
endfunction


command -nargs=+ S call s:surround(<f-args>)
nnoremap <silent> <Plug>SurroundNadd :<C-u>execute 'call '
    \v:count? '<SID>surroundNadd(v:count)' : '<SID>surroundNadd(1)'<CR>
nmap <M-s> <Plug>SurroundNadd
nmap ys <M-s>

nnoremap <silent> <Plug>SurroundNdel :<C-u>call <SID>surroundNdel()<CR>
nmap <M-d> <Plug>SurroundNdel
nmap ds <M-d>
