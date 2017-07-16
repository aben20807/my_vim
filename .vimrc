".vimrc
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev db bd
"let cursor in the middle of screen when entering vim
autocmd VimEnter * :exec "normal! \zz"
"快捷鍵
"儲存
nmap <F10> <ESC>:q!<CR>
nmap <F11> <ESC>:up<CR>
nmap <F12> <ESC>:up<CR>:q<CR>
"註解
autocmd FileType python nmap <C-l> <ESC><S-^>i# <ESC>
autocmd FileType python imap <C-l> <ESC><S-^>i# <ESC>i
autocmd FileType python vmap <C-l> <S-^><C-v><S-i># <ESC>
autocmd FileType python nmap <C-k> <ESC><S-^><C-V>ld
autocmd FileType python imap <C-k> <ESC><S-^><C-V>ldi
autocmd FileType python vmap <C-k> <C-v><S-^><S-o><S-^>ld<ESC>
autocmd FileType c,cpp nmap <C-l> <ESC><S-^>i// <ESC>
autocmd FileType c,cpp imap <C-l> <ESC><S-^>i// <ESC>i
autocmd FileType c,cpp vmap <C-l> <S-^><C-v><S-i>// <ESC>
autocmd FileType c,cpp nmap <C-k> <ESC><S-^><C-V>lld
autocmd FileType c,cpp imap <C-k> <ESC><S-^><C-V>lldi
autocmd FileType c,cpp vmap <C-k> <C-v><S-^><S-o><S-^>lld<ESC>

"分屏
"分屏間移動
nnoremap <silent> <C-Right> <C-w>l
nnoremap <silent> <C-Left> <C-w>h
nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-Down> <C-w>j
"移動分屏
nnoremap <silent> <C-S-Right> <C-w>L
nnoremap <silent> <C-S-Left> <C-w>H
nnoremap <silent> <C-S-Up> <C-w>K
nnoremap <silent> <C-S-Down> <C-w>J

""inoremap <silent> <C-h> <Left>
""inoremap <silent> <C-j> <Down>
""inoremap <silent> <C-k> <Up>
""inoremap <silent> <C-l> <Right>
"不用方向鍵
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
"在n可用滑鼠
set mouse=n


"預設程式
func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat)? '': c
endfunc

:iab #i #include <><LEFT><C-R>=Eatchar('\m\s\<bar>\r')<CR>
:iab _pr printf();<LEFT><LEFT><C-R>=Eatchar('\m\s\<bar>\r')<CR>
autocmd BufRead,BufNewFile *.h,*.c
            \:iab <buffer> _main #include <stdio.h>
            \<CR>
            \<CR>int main(int argc, char *argv[]){
            \<CR>
            \<CR>return 0;
            \}<BS><UP><C-R>=Eatchar('\m\s\<bar>\r')<CR>
autocmd BufRead,BufNewFile *.hpp,*.cpp
            \:iab <buffer> _main #include <iostream>
            \<CR>using namespace std;
            \<CR>
            \<CR>int main(){
            \<CR>
            \<CR>return 0;
            \}<BS><UP><C-R>=Eatchar('\m\s\<bar>\r')<CR>

"********************************************************************
set nocompatible              " 去除VI一致性,必須

" key 映射
let mapleader = ','         " 全局leader設置
let maplocalleader = '_'    " 本地leader設置

inoremap <leader>; <ESC>

" 導入vim插件管理
" load plugins from vundle
filetype off
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" 導入vim作者說明
if filereadable(expand("~/.vimrc.author"))
    source ~/.vimrc.author
endif

" 導入vim括號補全
if filereadable(expand("~/.vimrc.brackets"))
    source ~/.vimrc.brackets
endif

"不可見字符可視化，按F3切換
""set listchars=tab:│\ ,trail:\ ,extends:>,precedes:<,nbsp:.
""set list
""nnoremap <F3> :set list!<CR>

"讓.h不被認為是C++的
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
    autocmd BufRead,BufNewFile *.hpp,*.cpp set filetype=cpp
    autocmd BufNewFile,BufRead *.py,*.pyw set filetype=python
augroup END

"編譯並執行http://www.edbiji.com/doccenter/showdoc/24/nav/284.html
map <F5> :call CompileAndRun()<CR>
map <leader>r :call CompileAndRun()<CR>
"save -> close ALE -> execute -> open ALE
function! CompileAndRun()
    exec "vs"
    exec "ALEDisable"
    if &filetype == 'c'
        exec "!gcc -std=c11 % -o /tmp/a.out && time /tmp/a.out"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o /tmp/a.out && time /tmp/a.out"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!%
    elseif &filetype == 'python'
        exec "!time D:/cygwin/bin/python3 %"
    endif
    exec "ALEEnable"
endfunc

" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil <vim5632@rainslide.net>
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

"倒退鍵
set backspace=2
set tabstop=4

" 將制表符擴展為空格
set expandtab

" 讓 vim 把連續數量的空格視為一個制表符
set softtabstop=4

"縮排位元數
set shiftwidth=4

" Tab縮排
nmap <TAB> v>
nmap <S-TAB> v<
vmap <TAB> >gv
vmap <S-TAB> <gv

nnoremap 0 ^
nnoremap = $

"顯示最後一列
set ruler

"左下角一列
set showmode

" 顯示行號，按F2切換
nnoremap <F2> :set nonumber!<CR>
:set number
:set relativenumber

" 直接複製到系統剪貼簿
""set clipboard=unnamed
vnoremap <C-C> "+y
vnoremap <C-X> "+d
inoremap <C-V> <ESC>pi
" 黏貼板
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamedplus
    else
        set clipboard=unnamed
    endif
endif

" 禁止折行
set nowrap

" 背景主題
colorscheme ouo

" 高亮搜尋結果
set hlsearch

" 在關鍵字還沒完全輸入完畢前就顯示結果
set incsearch

set wildignore+=*.o,*.obj,*.pyc

" 語法高亮
syntax on

" 高亮顯示當前行/列
set cursorline
"set cursorcolumn

"在终端下打開256色
set t_Co=256

"搜尋不分大小寫
set ic

"設定文字編碼
set enc=utf8
scriptencoding utf-8

"分頁
set splitright
set splitbelow

 "最下出現總行數
set ruler

"禁止光標閃爍
set gcr=a:block-blinkon0

"設置歷史紀錄為1000條
set history=1000

set nobackup      " 不備份
set nowritebackup " 不寫入備份文件
set noswapfile    " 關閉交換文件
set mousehide     " 輸入文件時隱藏鼠標
set virtualedit=onemore             " 光標可以移到當行最後一個字符之後
" 基于縮排或語法進行代碼折叠
"操作：za，打開或關閉當前折叠；zM，關閉所有折叠；zR，打開所有折叠
"set foldmethod=indent
"set foldmethod=syntax
" 啟動 vim 時關閉折叠代碼
"set nofoldenable
