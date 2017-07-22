" Author: Huang Po-Hsuan <aben20807@gmail.com>
" Filename: .brackets.vim
" Last Modified: 2017-07-20 11:35:21
" Vim: enc=utf-8

"括號引號補全https://gist.github.com/nemtsov/11064497
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
"inoremap < <><Esc>i
inoremap { {}<Esc>i
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
endfunction

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if &filetype == 'vim' || &filetype == 'sh'
        " Just use " for comment
        return a:char
    elseif line[col - 2] == "\\"
        " Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        " Escaping out of the string
        return "\<Right>"
    else
        " Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endfunction
