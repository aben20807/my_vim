"括號引號補全
:inoremap { {<CR>}<ESC>O
:inoremap ( ()<ESC>i
:inoremap [ []<ESC>i
"":inoremap { {}<ESC>i		

"自動縮排：即每行的缩排與上一行相等；使用noautoindent取消
""nnoremap <F3> :set autoindent!<CR>
set autoindent

"設置 使用 C/C++ 語言的自動缩排方式：
""nnoremap <F3> :set cindent!<CR>
set cindent

"********************************************************************
" 將 pathogen 自身也置於獨立目錄中，需指定其路徑 
runtime /bundle/pathogen/autoload/pathogen.vim
" 運行 pathogen
execute pathogen#infect()

"倒退鍵
set backspace=2

set tabstop=4
set softtabstop=4

" 將制表符擴展為空格
set expandtab
" 讓 vim 把連續數量的空格視為一個制表符
set softtabstop=4

"縮排位元數
set shiftwidth=4

"顯示最後一列
set ruler

"左下角一列
set showmode

"顯示行號，按F2切換
nnoremap <F2> :set nonumber!<CR>

" 禁止折行
set nowrap

" 設置 gvim 顯示字體
set guifont=YaHei\ Consolas\ 17 " Hybrid\ 17

"背景
"set background=dark
"colorscheme nightshade
colorscheme rcg_gui
"colorscheme blackboard
"colorscheme xterm16

"高亮度反白
set hlsearch

"語法高亮
syntax on

" 高亮顯示當前行/列
set cursorline
"set cursorcolumn

"在终端下打開256色
"set t_Co=256

"搜尋不分大小寫
set ic

"設定文字編碼
set enc=utf8

"不套用Vi相容套件
set nocompatible

 "最下出現總行數
set ruler

"禁止光標閃爍
set gcr=a:block-blinkon0

"設置歷史紀錄為50條
set history=50

" 随 vim 自啟動
let g:indent_guides_enable_on_vim_startup=1
" 從第二層開始可視化顯示縮排
let g:indent_guides_start_level=2
" 色塊寬度
let g:indent_guides_guide_size=1
" 快捷鍵 b 開/關縮排可視化
:nmap <silent> <Leader>b <Plug>IndentGuidesToggle

" 基于縮排或語法進行代碼折叠
"操作：za，打開或關閉當前折叠；zM，關閉所有折叠；zR，打開所有折叠
"set foldmethod=indent
set foldmethod=syntax
" 啟動 vim 時關閉折叠代碼
set nofoldenable
