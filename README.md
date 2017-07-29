Vim Configuration
===
## Abbreviations
- File: .vimrc, .vim/after/ftplugin/vim.vim, .vim/after/ftplugin/rust.vim
- Ref: https://superuser.com/questions/487603/abbreviations-override-in-comments-and-quoted-text
- Use CodeAbbr function to check if enable abbreviations, e.g. disable in comment and string

```vim
function! CodeAbbr(abbr,str)
    let syn = synIDattr(synIDtrans(synID(line('.'), col('.') - 1, 1)), 'name')
    if syn ==? 'Comment' || syn ==? 'Constant' || syn ==? 'String' || syn ==? 'Special'
        return a:abbr
    else
        return a:str
    endif
endfunction
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
- After configurating, can use `<M-x>` to map key, x = a~z, A~Z, 0~9, some symbols

## Brackets
- File: .brackets.vim
- Post: [106.07.01 vim 括號自動配對](http://aben20807.blogspot.tw/2017/07/1060701-vim.html)

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
        exec "MarkdownPreview"
    else
        redraw
        echohl WarningMsg
            echo strftime("   ❖  不支援  ❖ ")
        echohl NONE
    endif
    exec "ALEEnable"
endfunc
```

## Markdown preview (Plugin)
- File: .bundles.vim
- Plugin: iamcco/markdown-preview.vim
- If want execute chrome in Cygwin use `cygstart` and copy a .lnk in root is easier

```vim
let g:mkdp_path_to_chrome = "cygstart /chrome.lnk"
let g:mkdp_auto_start = 0
```

## Terminal (Plugin)
- File: .bundles.vim
- Plugin: wkentaro/conque.vim
- Press `<C-t>` in narmal mode to open terminal in virtical split

```vim
nnoremap <C-t> :ConqueTermVSplit bash<CR>
```

## Time
- File: .keymap.vim
- Press `<M-t>`in normal mode to show what time it is

## Surround
- File: .surround.vim
- If inputed character is not supported, it will echo  ❖  不支援字元 ❖
- `<M-s>x`: Add x to surround one word which is under cursor, x = ' , " , ( , [ , { , <
- `<M-s>x`: Also can use in visual mode to surround selection
- `n<M-s>x`: Add x to surround n words, n is integer
- `<M-d>x`: Delete surround character x if have had in surround x
- `<M-f>xy`: Replace surround x into y
