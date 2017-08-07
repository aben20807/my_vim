Vim 配置整理
===
- 環境: Windows 10, Cygwin, Vim8

## Abbreviations (縮寫)
- 檔案: .vimrc, .vim/after/ftplugin/vim.vim, .vim/after/ftplugin/rust.vim
- 參考: https://superuser.com/questions/487603/abbreviations-override-in-comments-and-quoted-text
- 使用 CodeAbbr() 確認是否可以啟動縮寫功能，若為註解或字串不啟動
- 使用 Eatchar() 吃掉縮寫後的空白或換行字元
- e.g. 在.vim的檔案打 "function" 會自動補全

```vim
:iab <buffer> <expr> function CodeAbbr("function", "function
    \<CR>
    \<CR>endfunction
    \<UP><TAB>
    \<UP><ESC>$li <C-R>=Eatchar(\'\\m\\s\\<bar>\\r\')<CR>
    \")
```
![Demo](http://imgur.com/t9AjraP.gif)

## Airline-theme (Airline主題)
- 檔案: .vim/bundle/vim-airline-themes/autoload/airline/themes/ouo.vim
- 修改了警告、錯誤區塊的顏色

![Demo](http://imgur.com/XcWYhUQ.png)

## Alt key map (Alt鍵的mapping)
- 檔案: .keymap.vim
- 貼文: [106.07.19 vim map alt(meta) key](http://aben20807.blogspot.tw/2017/07/1060719-vim-map-altmeta-key.html)
- 設定後可用 `<M-x>` 來map Alt+x, 其中x 為 a\~z, A\~Z, 0\~9, 還有一些特殊符號像.和/

## Author Information (添加作者資訊)
- 檔案: .author.vim, .vim/after/ftplugin/\*.vim
- 參考:  http://www.gegugu.com/2016/02/11/17175.html
- 透過 `<F4>` 在文件開頭添加作者、檔案資訊
- 如果原本就有只會更新日期、檔名，沒有才會新增
- 請使用 AddTitle() 定義各檔案類型的資訊內容
- e.g 在 .vim/after/ftplugin/vim.vim 定義如下

```vim
function! AddTitle()
    call append(0,"\" Author: Huang Po-Hsuan <aben20807@gmail.com>")
    call append(1,"\" Filename: ".expand("%:t"))
    call append(2,"\" Last Modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(3,"\" Vim: enc=utf-8")
    call append(4,"")
endfunction
```
![Demo](http://imgur.com/m8vj8V7.png)

## Brackets (括號補全)
- 檔案: .brackets.vim
- 貼文: [106.07.01 vim 括號自動配對](http://aben20807.blogspot.tw/2017/07/1060701-vim.html)

## Colortheme (vim主題)
- 檔案: .vim/color/ouo.vim
- 對應的區塊大部分都在註解裡面了去找吧

## Comment (註解)
- 檔案: .comment.vim, .vim/after/ftplugin/\*.vim
- 請先在各個 ftplugin 的檔案中設定 call CommentFormat("")
- 使用 `<M-/>` 來註解或取消註解
- 使用 visual mode 可一次操作多行

![Demo](http://imgur.com/Dwwii0W.gif)

## Compile and Run (編譯執行)
- 檔案: .vimrc
- 參考: http://www.edbiji.com/doccenter/showdoc/24/nav/284.html
- 跳出之前會先關閉 ale
- 也可以切換 markdown 預覽

```vim
map <F5> :call CompileAndRun()<CR>
" save -> close ALE -> execute -> open ALE
function! CompileAndRun()
    " save only when changed
    exec "up"
    exec "ALEDisable"
    if &filetype == 'rust'
        exec "!rustc % && time ./%< && rm %<"
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
    elseif &filetype == 'markdown'
        " markdown preview
        try
            " Stop before starting and handle exception
            execute "MarkdownPreviewStop"
        catch /^Vim:E492:/
        endtry
        execute "MarkdownPreview"
    else
        redraw
        echohl WarningMsg
            echo strftime("   ❖  不支援  ❖ ")
        echohl NONE
    endif
    exec "ALEEnable"
endfunc
```
![Demo](http://imgur.com/qiUjtiF.gif)

## Completion (補全插件)
- 檔案: .bundles.vim
- 插件: [maralla/completor.vim](https://github.com/maralla/completor.vim)
- 插件(forked): [aben20807/completor.vim](https://github.com/aben20807/completor.vim)
- 在insert mode按 `<F7>` 開關

![Demo](http://imgur.com/RClIhwr.png)

## Indent highlight (縮排顯示插件)
- 檔案: .bundles.vim
- 插件: [Yggdroot/indentLine](https://github.com/Yggdroot/indentLine)
- 按 `<F3>` 開關顯示

```vim
Plugin 'Yggdroot/indentLine'
let g:indentLine_setColors = 0
let g:indentLine_char = '┊'
nnoremap <F3> :IndentLinesToggle<CR>
```

## Line number (行號)
- 檔案: .vimrc
- 混和版本: 目前行使用絕對行，其他行使用相對行
- 按 `<F2>` 開關顯示

```vim
nnoremap <F2> :set norelativenumber!<CR>:set nonumber!<CR>
:set number
:set relativenumber
```

## Markdown preview (Markdown預覽插件)
- 檔案: .bundles.vim
- 插件: [iamcco/markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim)
- cygwin 內啟動 chrome 的設定如下

```vim
let g:mkdp_path_to_chrome = "cygstart /chrome.lnk"
let g:mkdp_auto_start = 0
```
![Demo](http://imgur.com/Wyp2qvv.png)

## Remove trailing white space (移除空白)
- 檔案: .vimrc
- 來源: Vigil `<vim5632@rainslide.net>`
- 自動在寫檔前把行末空白、文件末空行刪除

```vim
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
```

## Surround (加上括號)
- 檔案: .surround.vim
- 如果輸入字元不支援會顯示  ❖  不支援字元 ❖
- `<M-s>x`: 在光標所在的單字左右加入x, 其中x 為 ' , " , \( , \[ , \{ , <
- `<M-s>x`: 在 visual mode 則在選取的左右加入
- `n<M-s>x`: 加在包含光標以後 n 個單字, n 為整數
- `<M-d>x`: 若有包在 x 裡面則刪除字元 x
- `<M-f>xy`: 用 y 取代 x

## Terminal (內部終端機插件)
- 檔案: .bundles.vim
- 插件: [wkentaro/conque.vim](https://github.com/wkentaro/conque.vim)
- 按 `<C-t>` 在分屏開啟終端機

```vim
nnoremap <C-t> :ConqueTermVSplit bash<CR>
```
![Demo](http://imgur.com/qsSb7Mh.png)

## Time (顯示時間)
- 檔案: .keymap.vim
- 在 normal mode 按 `<M-t>` 就會顯示現在時間

```vim
function! DateAndTime()
    redraw
    echohl WarningMsg
        echo strftime("   ❖  現在時間 %H:%M ❖ ")
    echohl NONE
endfunction
nnoremap <M-t> :call DateAndTime()<CR>
```

![Demo](http://imgur.com/bWHdrLr.png)
