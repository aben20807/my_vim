" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .comment.vim
" Last Modified: 2017-07-28 10:31:53
" Vim: enc=utf-8

" Comment map
" nmap <M-/> <ESC><S-^>i// <ESC>
" imap <M-/> <ESC><S-^>i// <ESC><BS>i
" vmap <M-/> <S-^><C-v><S-i>// <ESC>
" nmap <M-.> <ESC><S-^><C-V>lld
" imap <M-.> <ESC><S-^><C-V>lldi
" vmap <M-.> <C-v><S-^><S-o><S-^>lld<ESC>

function CommentFormat(format)
    let s:format = a:format
endfunction


function s:subString(from, to)
    let currentLine = getline(".")
	" let list = split(currentLine, '\zs')
    let i = a:from
    let result = ""
    while i < a:to
        let result .= currentLine[i]
        let i+=1
    endwhile
    return result
endfunction


function s:isComment()
    " let s:nowcol = col(".")
    execute "normal \<S-^>"
    let sub = s:subString(col(".")-1, col(".")-1+strlen(s:format))
    " execute "normal 0".(s:nowcol)."lh"
    if  sub ==# s:format
        return 1
        " redraw
        " echohl WarningMsg
        "     echo "   ❖  有註解 ❖ "
        " echohl NONE
    else
        return 0
        " redraw
        " echohl WarningMsg
        "     echo "   ❖  無註解 ❖ "
        " echohl NONE
    endif
    " echohl WarningMsg
    "     echo s:format
    "     echo sub
    " echohl NONE
    " recover sorcur position
endfunction


function s:comment()
    let s:nowcol = col(".")
    if s:isComment() ==# 1
        call s:commentDel()
        execute "normal 0".(s:nowcol - strlen(s:format) > 0? (s:nowcol - strlen(s:format)): 0)."lh"
    else
        call s:commentAdd()
        execute "normal 0".(s:nowcol + strlen(s:format))."lh"
    endif
endfunction


function s:commentAdd()
    execute "normal \<S-^>i".s:format."\<ESC>"
    redraw
    echohl WarningMsg
        echo "   ❖  加入註解 ❖ "
    echohl NONE
endfunction


function s:commentDel()
    execute "normal \<S-^>".strlen(s:format)."x"
    redraw
    echohl WarningMsg
        echo "   ❖  移除註解 ❖ "
    echohl NONE
endfunctio


" call CommentFormat("jj ")

nnoremap <silent> <Plug>Comment :<C-u>call <SID>comment()<CR>
nmap <M-/> <Plug>Comment
inoremap <silent> <Plug>Comment :<C-u>call <SID>comment()<CR>
imap <M-/> <ESC> <Plug>Comment hi