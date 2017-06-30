"快捷鍵
"儲存
nmap <F10> <ESC>:q!<CR>
nmap <F11> <ESC>:up<CR>
nmap <F12> <ESC>:up<CR>:q<CR>
"註解
imap <C-L> <ESC><S-^>i//
nmap <C-L> <ESC><S-^>i//<ESC>
imap <C-K> <ESC><S-^><C-V><RIGHT>di
nmap <C-K> <ESC><S-^><C-V><RIGHT>d
"預設程式
func Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat)? '': c
endfunc
:iab #i #include <><LEFT><C-R>=Eatchar('\m\s\<bar>\r')<CR>
:iab _pr printf();<LEFT><LEFT><C-R>=Eatchar('\m\s\<bar>\r')<CR>
 autocmd BufRead,BufNewFile *.h,*.c :iab <buffer> _main #include <stdio.h>
			\<CR>
			\<CR>int main(int argc, char *argv[]){
			\<CR>
			\<CR>return 0;
			\}<BS><UP><C-R>=Eatchar('\m\s\<bar>\r')<CR>
autocmd BufRead,BufNewFile *.hpp,*.cpp :iab <buffer> _main #include <iostream>
			\<CR>using namespace std;
			\<CR>
			\<CR>int main(){
			\<CR>
			\<CR>return 0;
			\}<BS><UP><C-R>=Eatchar('\m\s\<bar>\r')<CR>
"括號引號補全https://gist.github.com/nemtsov/11064497
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
"inoremap < <><Esc>i
inoremap {} {}<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
inoremap ) <C-R>=ClosePair(')')<CR>
inoremap ] <C-R>=ClosePair(']')<CR>
"inoremap > <C-R>=ClosePair('>')<CR>
inoremap } <C-R>=ClosePair('}')<CR>
inoremap " <C-R>=QuoteDelim('"')<CR>
inoremap ' <C-R>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf

"********************************************************************
set nocompatible              " 去除VI一致性,必須
filetype off                  " 必須

" 設置包括vundle和初始化相關的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一種選擇, 指定一個vundle安裝插件的路徑" :BundleInstall
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
map <F8> :up<CR>:bp<CR>
map <F9> :up<CR>:bn<CR>
"256 色測試
" Plugin 'git://github.com/guns/xterm-color-table.vim.git'
"https://github.com/guns/xterm-color-table.vim.git
" Plugin 'Valloric/YouCompleteMe' "YouCompleteMe托管在github上，使用vundle安装
" let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra _conf.py'
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
"不可見字符可視化
set list lcs=tab:\▏\ 
nnoremap <F3> :set list!<CR>
"讓.h不被認為是C++的
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
    autocmd BufRead,BufNewFile *.hpp,*.cpp set filetype=cpp
augroup END

map <F5> :call CompileAndRun()<CR>
func! CompileAndRun()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -std=c11 % -o /tmp/a.out && /tmp/a.out"
	elseif &filetype == 'cpp'
		exec "!g++ -std=c++11 % -o /tmp/a.out && /tmp/a.out"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!%
	elseif &filetype == 'python'
		exec "!python3 %"
	endif
endfunc
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

"背景
colorscheme special_desert

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

" 基于縮排或語法進行代碼折叠
"操作：za，打開或關閉當前折叠；zM，關閉所有折叠；zR，打開所有折叠
"set foldmethod=indent
"set foldmethod=syntax
" 啟動 vim 時關閉折叠代碼
"set nofoldenable
