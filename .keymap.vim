" key 映射
let mapleader = ','         " 全局leader設置
let maplocalleader = '_'    " 本地leader設置
inoremap <leader>; <ESC>

" 離開vim
nnoremap <F10> :exec "q!"<CR>
nnoremap <F11> :exec "w"<CR>
nnoremap <F12> :exec "wq"<CR>

" 註解Comment
autocmd FileType python nmap <M-/> <ESC><S-^>i# <ESC>
autocmd FileType python imap <M-/> <ESC><S-^>i# <ESC><BS>i
autocmd FileType python vmap <M-/> <S-^><C-v><S-i># <ESC>
autocmd FileType python nmap <M-.> <ESC><S-^><C-V>ld
autocmd FileType python imap <M-.> <ESC><S-^><C-V>ldi
autocmd FileType python vmap <M-.> <C-v><S-^><S-o><S-^>ld<ESC>
autocmd FileType c,cpp  nmap <M-/> <ESC><S-^>i// <ESC>
autocmd FileType c,cpp  imap <M-/> <ESC><S-^>i// <ESC><BS>i
autocmd FileType c,cpp  vmap <M-/> <S-^><C-v><S-i>// <ESC>
autocmd FileType c,cpp  nmap <M-.> <ESC><S-^><C-V>lld
autocmd FileType c,cpp  imap <M-.> <ESC><S-^><C-V>lldi
autocmd FileType c,cpp  vmap <M-.> <C-v><S-^><S-o><S-^>lld<ESC>
autocmd FileType vim nmap <M-/> <ESC><S-^>i" <ESC>
autocmd FileType vim imap <M-/> <ESC><S-^>i" <ESC><BS>i
autocmd FileType vim vmap <M-/> <S-^><C-v><S-i>" <ESC>
autocmd FileType vim nmap <M-.> <ESC><S-^><C-V>ld
autocmd FileType vim imap <M-.> <ESC><S-^><C-V>ldi
autocmd FileType vim vmap <M-.> <C-v><S-^><S-o><S-^>ld<ESC>

" 分屏間移動window
nnoremap <silent> <C-Right> <C-w>l
nnoremap <silent> <C-Left>  <C-w>h
nnoremap <silent> <C-Up>    <C-w>k
nnoremap <silent> <C-Down>  <C-w>j

" 移動分屏
nnoremap <silent> <C-S-Right> <C-w>L
nnoremap <silent> <C-S-Left>  <C-w>H
nnoremap <silent> <C-S-Up>    <C-w>K
nnoremap <silent> <C-S-Down>  <C-w>J

" buffer間移動
nnoremap <silent> <C-l>     :bn!<CR>
nnoremap <silent> <C-h>     :bp!<CR>
nnoremap <silent> <C-k>     :bp!<CR>
nnoremap <silent> <C-j>     :bn!<CR>

" 不用方向鍵
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
"noremap   <Up>     <NOP>
"noremap   <Down>   <NOP>
"noremap   <Left>   <NOP>
"noremap   <Right>  <NOP>

" 快速移動
nnoremap <M-h> 5h
nnoremap <M-j> 5j
nnoremap <M-k> 5k
nnoremap <M-l> 5l

" insert移動
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

" commend移動
cnoremap <M-h> <c-left>
cnoremap <M-l> <c-right>
cnoremap <M-k> <c-left>
cnoremap <M-j> <c-right>

" Tab縮排
nmap <TAB> v>
nmap <S-TAB> v<
vmap <TAB> >gv
vmap <S-TAB> <gv

" 讓=移到最後再後
nnoremap = $l

" 直接複製到系統剪貼簿
" vnoremap <C-C> "+y
" vnoremap <C-X> "+d
" inoremap <C-V> <ESC>pi
" insert貼上
inoremap <M-p> <ESC>pi<Right>

" 關閉搜尋高亮
noremap <M-n> :noh<CR>

" map alt key
function! Terminal_MetaMode(mode)
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
    if &ttimeout == 0
        set ttimeout
    endif
    if &ttimeoutlen <= 0
        set ttimeoutlen=100
    endif
endfunc
call Terminal_MetaMode(0)
