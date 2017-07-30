Vim Configuration
===
- Environment: Windows10, Cygwin, Vim8

## Abbreviations
- File: .vimrc, .vim/after/ftplugin/vim.vim, .vim/after/ftplugin/rust.vim
- Ref: https://superuser.com/questions/487603/abbreviations-override-in-comments-and-quoted-text
- Use CodeAbbr() function to check if be able to enable abbreviations
- Use Eatchar() function to eat last input when triggering abbrevation
- e.g. type "if" in .vim

```vim
:iab <buffer> <expr> if CodeAbbr("if", "if
    \<CR>
    \<CR>endif
    \<UP><TAB>
    \<UP><ESC>$li <C-R>=Eatchar(\'\\m\\s\\<bar>\\r\')<CR>
    \")
```

## Airline-theme
- File: .vim/bundle/vim-airline-themes/autoload/airline/themes/ouo.vim
- Change warning and error sections highlight

```vim
let g:airline#themes#ouo#palette.normal.airline_warning = s:W
let g:airline#themes#ouo#palette.normal.airline_error = s:E
```

## Alt key map
- File: .keymap.vim
- Blogger: [106.07.19 vim map alt(meta) key](http://aben20807.blogspot.tw/2017/07/1060719-vim-map-altmeta-key.html)
- After configurating, can use `<M-x>` to map key, x = a~z, A~Z, 0~9, some symbols like . and /

## Author Information
- File: .author.vim, .vim/after/ftplugin/\*.vim
- Ref:  http://www.gegugu.com/2016/02/11/17175.html
- Press `<F4>` to add author informations in the front
- If it has existed, updating only, otherwise adding
- Please define AddTitle() finction against different file type
- e.g in .vim/after/ftplugin/vim.vim

```vim
function! AddTitle()
    call append(0,"\" Author: Huang Po-Hsuan <aben20807@gmail.com>")
    call append(1,"\" Filename: ".expand("%:t"))
    call append(2,"\" Last Modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(3,"\" Vim: enc=utf-8")
    call append(4,"")
endfunction
```

## Brackets
- File: .brackets.vim
- Blogger: [106.07.01 vim 括號自動配對](http://aben20807.blogspot.tw/2017/07/1060701-vim.html)

## Colortheme
- File: .vim/color/ouo.vim
- Corresponding sections all commented in file

## Comment
- File: .comment.vim
- Can use `<M-/>` to map comment and uncomment at the same time
- Use visual mode can comment multiple lines

## Compile and Run
- File: .vimrc
- Ref: http://www.edbiji.com/doccenter/showdoc/24/nav/284.html
- Before executing command, disable ale first
- Also be used to preview markdown

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

## Indent highlight (Plugin)
- File: .bundles.vim
- Plugin: [nathanaelkane/vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides)
- Press `<F3>` to toggle enable or not

```vim
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'log']
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
nnoremap <F3> :IndentGuidesToggle<CR>
```

## Line number
- File: .vimrc
- Hybrid line number: current line is absolute and others are relative
- Press `<F2>` to toggle if display line number

```vim
nnoremap <F2> :set norelativenumber!<CR>:set nonumber!<CR>
:set number
:set relativenumber
```

## Markdown preview (Plugin)
- File: .bundles.vim
- Plugin: [iamcco/markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim)
- If want execute chrome in Cygwin use `cygstart` and copy a .lnk in root is easier

```vim
let g:mkdp_path_to_chrome = "cygstart /chrome.lnk"
let g:mkdp_auto_start = 0
```

## Remove trailing white space
- File: .vimrc
- From: Vigil `<vim5632@rainslide.net>`
- Remove trailing whitespace when writing a buffer, but not for diff files.

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

## Surround
- File: .surround.vim
- If inputed character is not supported, it will echo  ❖  不支援字元 ❖
- `<M-s>x`: Add x to surround one word which is under cursor, x = ' , " , \( , \[ , \{ , <
- `<M-s>x`: Also can use in visual mode to surround selection
- `n<M-s>x`: Add x to surround n words, n is integer
- `<M-d>x`: Delete surround character x if have had in surround x
- `<M-f>xy`: Replace surround x into y

## Terminal (Plugin)
- File: .bundles.vim
- Plugin: [wkentaro/conque.vim](https://github.com/wkentaro/conque.vim)
- Press `<C-t>` in narmal mode to open terminal in virtical split

```vim
nnoremap <C-t> :ConqueTermVSplit bash<CR>
```

## Time
- File: .keymap.vim
- Press `<M-t>`in normal mode to show what time it is
