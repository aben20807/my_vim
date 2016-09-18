"括號引號補全
":inoremap { {<CR>}<ESC>O
":inoremap ( ()<ESC>i
":inoremap [ []<ESC>i
"":inoremap " ""<ESC>i
"":inoremap { {}<ESC>i		

"自動縮排：即每行的缩排與上一行相等；使用noautoindent取消
""nnoremap <F3> :set autoindent!<CR>
"set autoindent

"設置 使用 C/C++ 語言的自動缩排方式：
""nnoremap <F3> :set cindent!<CR>
"set cindent

"********************************************************************
set nocompatible              " 去除VI一致性,必須
filetype off                  " 必須

" 設置包括vundle和初始化相關的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一種選擇, 指定一個vundle安裝插件的路徑
"call vundle#begin('~/some/path/here')

" 讓vundle管理插件版本,必須
Plugin 'VundleVim/Vundle.vim'
"狀態條
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_theme='murmur'
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
map <F3> :up<CR>:bp<CR>
map <F4> :up<CR>:bn<CR>
"Bundle 'Valloric/YouCompleteMe'
"縮排可視化
"Plugin 'Yggdroot/indentLine'
"let g:indentLine_color_term = 250
"let g:indentLine_char = '|'
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
"let g:indentLine_enabled = 0
" 以下範例用來支持不同格式的插件安裝.
" 請將安裝插的命令放在vundle#begin和vundle#end之間.
" Github上的插件
" 格式為 Plugin '用戶名/插件倉庫名'
"Plugin 'tpope/vim-fugitive'
" 來自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名稱' 實際上是 Plugin 'vim-scripts/插件倉庫名'
"只是此處的用戶名可以省略
"Plugin 'L9'
"由Git支持但不再github上的插件倉庫 Plugin 'git clone 後面的地址'
"Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git倉庫(例如自己的插件) Plugin 'file:///+本地插件倉庫絕對路徑'
"Plugin 'file:///home/gmarik/path/to/plugin'
"Plugin 'file://C:/cygwin64/home/user/.vim/bundle/xterm-color-table.vim-master/plugin'
"256 色測試
Plugin 'git://github.com/guns/xterm-color-table.vim.git'
"https://github.com/guns/xterm-color-table.vim.git
" 插件在倉庫的子目錄中.
" 正確指定路徑用以設置runtimepath. 以下範例插件在sparkup/vim目錄下
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安裝L9，如果已經安裝過這個插件，可利用以下格式避免命名衝突
"Plugin 'ascenator/L9', {'name': 'newL9'}

" 你的所有插件需要在下面這行之前
call vundle#end()            " 必須
filetype plugin indent on    " 必須
"加載vim自帶和插件相應的語法和文件類型相關腳本
" 忽視插件改變縮進,可以使用以下替代:
"filetype plugin on
"
" 簡要幫助文檔
" :PluginList       - 列出所有已配置的插件
" :PluginInstall    - 安裝插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地緩存
" :PluginClean      - 清除未使用插件,需要確認; 追加 `!`
"自動批准移除未使用插件

" 查閱 :h vundle 獲取更多細節和wiki以及FAQ
" 將你自己對非插件片段放在這行之後
"********************************************************************
" 將 pathogen 自身也置於獨立目錄中，需指定其路徑 
"runtime /bundle/pathogen/autoload/pathogen.vim
" 運行 pathogen
"execute pathogen#infect()
"不可見字符可視化
:set list lcs=tab:\│\ 
"讓.h不被認為是C++的
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END
"倒退鍵
set backspace=2
set tabstop=4
set softtabstop=4
" 將制表符擴展為空格
set noexpandtab
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
"set guifont=YaHei\ Consolas\ 17 " Hybrid\ 17

"背景
"set background=dark
"colorscheme nightshade
""colorscheme rcg_gui
"colorscheme blackboard
colorscheme special_desert
"colorscheme jellybeans_modified

"高亮度反白
set hlsearch

"語法高亮
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

"不套用Vi相容套件
set nocompatible

 "最下出現總行數
set ruler

"禁止光標閃爍
set gcr=a:block-blinkon0

"設置歷史紀錄為50條
set history=50

" 随 vim 自啟動
"let g:indent_guides_enable_on_vim_startup=1
" 從第二層開始可視化顯示縮排
"let g:indent_guides_start_level=2
" 色塊寬度
"let g:indent_guides_guide_size=1
" 快捷鍵 b 開/關縮排可視化
":nmap <silent> <Leader>b <Plug>IndentGuidesToggle

" 基于縮排或語法進行代碼折叠
"操作：za，打開或關閉當前折叠；zM，關閉所有折叠；zR，打開所有折叠
"set foldmethod=indent
"set foldmethod=syntax
" 啟動 vim 時關閉折叠代碼
"set nofoldenable
:ab _pr printf("");<LEFT><LEFT>
:ab _main #include <stdio.h><CR><CR>int main(int argc, char *argv[]){<CR><CR>return 0;<CR>}<UP><UP>
