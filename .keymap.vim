" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .keymap.vim
" Last Modified: 2017-07-22 11:33:35
" Vim: enc=utf-8

" key 映射
" let mapleader = ','         " 全局leader設置
" let maplocalleader = '_'    " 本地leader設置
" inoremap <leader>; <ESC>

" 離開vim
nnoremap <F10> :exec "q!"<CR>
nnoremap <F11> :exec "w"<CR>
nnoremap <F12> :exec "wq"<CR>

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

" 分屏大小
nnoremap <M-+> <C-w>10>
nnoremap <M--> <C-w>10<
nnoremap <M-=> <C-w>=
nnoremap <M-_> <C-w>30><C-w>30+

" buffer間移動
nnoremap <silent> <C-l>     :bn!<CR>
nnoremap <silent> <C-h>     :bp!<CR>
nnoremap <silent> <C-k>     :bp!<CR>
nnoremap <silent> <C-j>     :bn!<CR>

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

" 加上()[]{}''""https://www.ctolib.com/docs-learn-vim-c-s1cidozt.html
nnoremap <M-w>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <M-w>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <M-w>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <M-w>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <M-w>{ viw<esc>a}<esc>bi{<esc>lel
" nnoremap <expr> v:count==0?":<M-w>( viw<esc>a)<esc>v:count.bi(<esc>lel
" nnnoremap <M-w> :call Surround('"')<CR>
function Surround(num, mode)
    if a:mode != "'" && a:mode != '"' && a:mode != '"' && a:mode != '{' && a:mode != '[' && a:mode != '('
        redraw
        echohl WarningMsg
            echo "   ❖  此字元不支援 ❖ "
        echohl NONE
        return
    endif
    call feedkeys("viw\<ESC>bi", "n")
    call feedkeys(a:mode, "t")
    call feedkeys("\<DEL>\<ESC>", "n")
    for i in range(a:num)
        call feedkeys("e", "n")
    endfor
    call feedkeys("a", "n")
    call feedkeys(a:mode, "t")
    call feedkeys("\<BS>\<ESC>\<RIGHT>", "n")
endfunction
command -nargs=+ S call Surround(<f-args>)

" 時間顯示http://vim.wikia.com/wiki/Insert_current_date_or_time
function! DateAndTime()
    redraw
    echohl WarningMsg
        echo "\n"
        echo strftime("   ❖  現在時間 %H:%M ❖ ")
        echo ""
    echohl NONE
endfunction
nnoremap <M-t> :call DateAndTime()<CR>

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
        for c in ['?', ':', '-', '_', '+', '=']
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
