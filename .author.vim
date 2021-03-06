" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .author.vim
" Last Modified: 2017-07-20 11:27:01
" Vim: enc=utf-8

" http://www.gegugu.com/2016/02/11/17175.html
" 進行作者說明的設置
" 添加或更新頭
map <F4> :call TitleDet()<CR>
" autocmd BufWritePre,VimLeavePre * call TitleDet()
function AddTitle()
endfunction
" 更新最近修改時間和文件名
function UpdateTitle()
    if &filetype == 'python'
        normal m'
        execute '/# *Last Modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
        normal ''
        normal mk
        execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
    elseif &filetype == 'vim'
        normal m'
        execute '/\" *Last Modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
        normal ''
        normal mk
        execute '/\" *Filename:/s@:.*$@\=": ".expand("%:t")@'
    elseif &filetype == 'c' || &filetype == 'cpp' || &filetype == 'rust'
        normal m'
        execute '/\/\/ *Last Modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
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
    while n < 5
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\sModified:\S*.*$' ||
          \line =~ '^\/\/\s*\S*Last\sModified:\S*.*$' ||
          \line =~ '^\"\s*\S*Last\sModified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
