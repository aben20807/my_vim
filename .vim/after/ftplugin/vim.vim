" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: vim.vim
" Last Modified: 2017-07-23 11:46:11
" Vim: enc=utf-8

" Comment map
nmap <M-/> <ESC><S-^>i" <ESC>
imap <M-/> <ESC><S-^>i" <ESC><BS>i
vmap <M-/> <S-^><C-v><S-i>" <ESC>
nmap <M-.> <ESC><S-^><C-V>ld
imap <M-.> <ESC><S-^><C-V>ldi
vmap <M-.> <C-v><S-^><S-o><S-^>ld<ESC>

" Title information
function! AddTitle()
    call append(0,"\" Author: Huang Po-Hsuan <aben20807@gmail.com>")
    call append(1,"\" Filename: ".expand("%:t"))
    call append(2,"\" Last Modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(3,"\" Vim: enc=utf-8")
    call append(4,"")
endfunction

" Abbreviations
:iab function function
    \<CR>
    \<CR>endfunction
    \<UP><TAB>
    \<UP><ESC>$li <C-R>=Eatchar('\m\s\<bar>\r')<CR>
:iab if if
    \<CR>
    \<CR>endif
    \<UP><TAB>
    \<UP><ESC>$li <C-R>=Eatchar('\m\s\<bar>\r')<CR>
:iab for for
    \<CR>
    \<CR>endfor
    \<UP><TAB>
    \<UP><ESC>$li <C-R>=Eatchar('\m\s\<bar>\r')<CR>
