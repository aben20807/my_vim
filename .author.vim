" http://www.gegugu.com/2016/02/11/17175.html
" 進行作者說明的設置
" 添加或更新頭
map <F4> :call TitleDet()<CR>
autocmd BufWritePre,VimLeavePre * call TitleDet()
"autocmd BufNewFile *.py :call TitleDet()
function AddTitle()
    if &filetype == 'python'
        call append(0,"# !D:/cygwin/bin/python3")
        call append(1,"# Version: python3.6")
        call append(2,"# Vim: enc=utf-8")
        call append(3,"# Author: Huang Po-Hsuan <aben20807@gmail.com>")
        call append(4,"# Filename: ".expand("%:t"))
        call append(5,"# Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(6,"#-*- coding: UTF-8 -*-")
        call append(7,"")
    elseif &filetype == 'cpp'
        call append(0,"// !g++ -std=c++11")
        call append(1,"// Version: C++11")
        call append(2,"// Vim: enc=utf-8")
        call append(3,"// Author: Huang Po-Hsuan <aben20807@gmail.com>")
        call append(4,"// Filename: ".expand("%:t"))
        call append(5,"// Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(6,"")
    elseif &filetype == 'c'
        call append(0,"// !gcc -std=c11")
        call append(1,"// Version: C11")
        call append(2,"// Vim: enc=utf-8")
        call append(3,"// Author: Huang Po-Hsuan <aben20807@gmail.com>")
        call append(4,"// Filename: ".expand("%:t"))
        call append(5,"// Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(6,"")
    endif
endfunction
" 更新最近修改時間和文件名
function UpdateTitle()
    if &filetype == 'python'
        normal m'
        execute '/# *Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
        normal ''
        normal mk
        execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
    elseif &filetype == 'c' || &filetype == 'cpp'
        normal m'
        execute '/\/\/ *Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
        normal ''
        normal mk
        execute '/\/\/ *Filename:/s@:.*$@\=": ".expand("%:t")@'
    endif
    execute "noh"
    normal 'k
endfunction
" 判斷前10行代碼裡面，是否有Last modified這個單詞，
" 如果沒有的話，代表沒有添加過作者信息，需要新添加；
" 如果有的話，那麼只需要更新即可
function TitleDet()
    let n=1
    "默認為添加
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$' || line =~ '^\/\/\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
