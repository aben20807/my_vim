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
