" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .bundles.vim
" Last Modified: 2017-07-22 00:03:11
" Vim: enc=utf-8

" 設置包括vundle和初始化相關的runtime path
filetype off
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
let g:airline_theme='ouo'
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
"let g:airline_section_warning = '%{ALEGetStatusLine()}'
let g:airline#extensions#ale#enabled = 1
"let g:airline_section_error = '%{ALEGetError()}'
"let g:airline_section_warning = '%{ALEGetWarning()}'
let airline#extensions#ale#error_symbol = 'E'
let airline#extensions#ale#warning_symbol = 'W'
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '㉿' " ''
map <F6> :bp!<CR>
map <F7> :bn!<CR>

" airline git symbol
" let vim slow QuQ
" Plugin 'tpope/vim-fugitive'

"256 色測試
" Plugin 'git://github.com/guns/xterm-color-table.vim.git'
"https://github.com/guns/xterm-color-table.vim.git
" Plugin 'Valloric/YouCompleteMe' "YouCompleteMe托管在github上，使用vundle安装
" let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra _conf.py'

" 文件索引樹
Plugin 'scrooloose/nerdtree'
" NerdTree配置 control+e打開當前文件目錄樹
map <C-n> :NERDTreeToggle<CR>
map <leader>ee :NERDTreeToggle<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.exe', '\.o']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
"寬度
let NERDTreeWinSize=25
Plugin 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified" : "✹",
    \ "Staged" : "✚",
    \ "Untracked" : "✭",
    \ "Renamed" : "➜",
    \ "Unmerged" : "═",
    \ "Deleted" : "✖",
    \ "Dirty" : "✗",
    \ "Clean" : "✔︎",
    \ "Unknown" : "?"
    \ }
function! s:ShowFilename()
    redraw | echohl Debug |
        \ echom index(["\" Press ? for help", "", ".. (up a dir)"], getline(".")) < 0 ?
        \ "NERDTree: " . matchstr(getline("."), "[0-9A-Za-z_/].*") : "" | echohl None
endfunction
autocmd CursorMoved NERD_tree* :call <SID>ShowFilename()

" 多光標
"http://www.wklken.me/posts/2015/06/07/vim-plugin-multiplecursors.html
Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=1
" Default mapping
 let g:multi_cursor_next_key='<C-o>' "選中一個
 let g:multi_cursor_prev_key='<C-p>' "放棄一個，回到上一個
 let g:multi_cursor_skip_key='<C-x>' "跳過
 let g:multi_cursor_quit_key='<Esc>' "退出

" 縮排高亮
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
nnoremap <F3> :IndentGuidesToggle<CR>

" 括號刪除取代
Plugin 'tpope/vim-surround'

"迷宮遊戲
" Plugin 'vim-scripts/HJKL'
" nnoremap <M-g> :HJKL<CR>

"內部終端機
Plugin 'wkentaro/conque.vim'
nnoremap <C-t> :ConqueTermVSplit bash<CR>

"語法檢查
Plugin 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'c': ['clang'],
\   'cpp': ['clang'],
\   'python': ['pylint'],
\   'vim': ['vint'],
\   'rust': ['rustc', 'cargo']
\}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_enter = 0
let g:ale_set_signs = 1
let g:ale_sign_error = '◈'
let g:ale_sign_warning = '◈'
" check only after savind
let g:ale_lint_on_text_changed = 'never'
nnoremap <M-a> :ALEToggle<CR>
nmap <M-w> <Plug>(ale_previous_wrap)
nmap <M-e> <Plug>(ale_next_wrap)
autocmd VimEnter,Colorscheme * :hi ALEErrorSign     cterm=bold ctermfg=160
autocmd VimEnter,Colorscheme * :hi ALEWarningSign   cterm=bold ctermfg=166
autocmd VimEnter,Colorscheme * :hi ALEErrorLine     cterm=NONE
autocmd VimEnter,Colorscheme * :hi ALEError         cterm=NONE ctermfg=251 ctermbg=160
autocmd VimEnter,Colorscheme * :hi ALEWarning       cterm=NONE ctermfg=251 ctermbg=166

Plugin 'rust-lang/rust.vim'

" 簡單補全
Plugin 'maralla/completor.vim'
let g:completor_racer_binary='/cygdrive/c/users/user/.cargo/bin/racer.exe'
let g:completor_clang_binary='/cygdrive/d/cygwin/bin/clang'
let g:completor_completion_delay=0
let g:completor_auto_trigger=1
function! CompletorToggle()
    if g:completor_auto_trigger==0
        let g:completor_auto_trigger=1
    else
        let g:completor_auto_trigger=0
    endif
    set noshowmode
    redraw
    echohl WarningMsg
        echo "completor ".((g:completor_auto_trigger==0)? "close": "open")
    echohl NONE
endfunction
inoremap <C-x> <C-\><C-O>:call CompletorToggle()<CR>
:autocmd CursorMoved,CursorMovedI,InsertChange * :set showmode
inoremap <expr> <TAB> pumvisible() ?"\<C-n>": "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ?"\<C-p>": "\<S-TAB>"
" inoremap <expr> <CR> pumvisible() ?"\<C-y>\<CR>": "\<CR>"

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
