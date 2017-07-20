" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: python.vim
" Last Modified: 2017-07-20 11:33:50
" Vim: enc=utf-8

nmap <M-/> <ESC><S-^>i# <ESC>
imap <M-/> <ESC><S-^>i# <ESC><BS>i
vmap <M-/> <S-^><C-v><S-i># <ESC>
nmap <M-.> <ESC><S-^><C-V>ld
imap <M-.> <ESC><S-^><C-V>ldi
vmap <M-.> <C-v><S-^><S-o><S-^>ld<ESC>

" Title information
function! AddTitle()
    call append(0,"# Author: Huang Po-Hsuan <aben20807@gmail.com>")
    call append(1,"# Filename: ".expand("%:t"))
    call append(2,"# Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(3,"# Vim: enc=utf-8")
    call append(4,"# Python Version: 3.6")
    call append(5,"# !D:/cygwin/bin/python3")
    call append(6,"#-*- coding: UTF-8 -*-")
    call append(7,"")
endfunction
