" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .vimrc
" Last Modified: 2017-07-20 16:20:26
" Vim: enc=utf-8

cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev db bd
" let cursor in the middle of screen when entering vim
autocmd VimEnter * :exec "normal! \zz"
" Keep 3 lines below and above the cursor
set scrolloff=3

" 在n, i可用滑鼠選取
set mouse=v

" 預設程式
func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat)? '': c
endfunc

set nocompatible              " 去除VI一致性,必須

" 導入 vim key map
if filereadable(expand("~/.keymap.vim"))
   source ~/.keymap.vim
endif

" 導入vim插件管理
" load plugins from vundle
if filereadable(expand("~/.bundles.vim"))
    source ~/.bundles.vim
endif

" 導入vim作者說明
if filereadable(expand("~/.author.vim"))
   source ~/.author.vim
endif

" 導入vim括號補全
if filereadable(expand("~/.brackets.vim"))
    source ~/.brackets.vim
endif

"不可見字符可視化，按F3切換
""set listchars=tab:│\ ,trail:\ ,extends:>,precedes:<,nbsp:.
""set list
""nnoremap <F3> :set list!<CR>

set omnifunc=syntaxcomplete#Complete

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
" close ALE -> execute -> open ALE
function! CompileAndRun()
    exec "ALEDisable"
    if &filetype == 'rust'
        exec "!rustc % && time ./%<"
    elseif &filetype == 'c'
        exec "!gcc -std=c11 % -o /tmp/a.out && time /tmp/a.out"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o /tmp/a.out && time /tmp/a.out"
    elseif &filetype == 'java'
        exec "!javac -encoding utf-8 %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!%
    elseif &filetype == 'python'
        exec "!time python3 %"
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

" 倒退鍵
set backspace=2
set tabstop=4

" 將制表符擴展為空格
set expandtab

" 讓 vim 把連續數量的空格視為一個制表符
set softtabstop=4

" 縮排位元數
set shiftwidth=4

" 顯示最後一列
set ruler

" 左下角一列
set showmode

" 顯示行號，按F2切換
nnoremap <F2> :set norelativenumber!<CR>:set nonumber!<CR>
:set number
:set relativenumber

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

" 在终端下打開256色
set t_Co=256

" 搜尋不分大小寫
set ic

" 設定文字編碼
set enc=utf8
scriptencoding utf-8

" 分頁
set splitright
set splitbelow

" 最下出現總行數
set ruler

" 禁止光標閃爍
set gcr=a:block-blinkon0

" 設置歷史紀錄為1000條
set history=1000

" 從外部修改後自動更新
set autoread

" 不顯示 -- 插入 --
" set noshowmode

" 不備份
set nobackup
" 不寫入備份文件
set nowritebackup
" 關閉交換文件
set noswapfile
" 輸入文件時隱藏鼠標
set mousehide
" 光標可以移到當行最後一個字符之後
set virtualedit=onemore
" 基于縮排或語法進行代碼折叠
"操作：za，打開或關閉當前折叠；zM，關閉所有折叠；zR，打開所有折叠
"set foldmethod=indent
"set foldmethod=syntax
" 啟動 vim 時關閉折叠代碼
"set nofoldenable
