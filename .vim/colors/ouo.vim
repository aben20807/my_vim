" Vim color file
" Maintainer:   Huang Po-Hsuan <aben20807@gmail.com>
" Last Change:  $Date: 2017/07/04 11:42:11 $
" URL:
" Version:  $Id: ouo.vim,v 1.0 fugalh Exp $
" modified from desert
"
" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="ouo"

hi Normal   guifg=White guibg=grey20

" highlight groups
hi Cursor   guibg=indianred guifg=khaki
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit    guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded   guibg=grey30 guifg=gold
hi FoldColumn   guibg=grey30 guifg=tan
hi IncSearch    guifg=slategrey guibg=khaki
"hi LineNr  guifg=#666666 guibg=#666666
hi ModeMsg  guifg=goldenrod
hi MoreMsg  guifg=SeaGreen
hi NonText  guifg=LightBlue guibg=grey30
hi Question guifg=springgreen
hi Search   guibg=grey30 guifg=#dfffdf
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guibg=#c2bfa5 guifg=black gui=none
hi StatusLineNC guibg=#c2bfa5 guifg=grey50 gui=none
hi Title    guifg=indianred
hi Visual   gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS gui=none guifg=khaki guibg=olivedrab

hi WarningMsg   guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip
hi MatchParen guibg=grey30 guifg=#dfffdf

" syntax highlighting groups
hi Comment  guifg=SkyBlue
hi Constant guifg=#ffa0a0
hi Identifier   guifg=palegreen
hi Statement    guifg=khaki
hi PreProc  guifg=indianred
hi Type     guifg=darkkhaki
hi Special  guifg=navajowhite
"hi Underlined
hi Ignore   guifg=grey40
"hi Error
hi Todo     guifg=orangered guibg=yellow2

" color terminal definitions
if &t_Co > 255
    hi Comment          ctermfg=238 cterm=italic    "註解

    hi Constant         ctermfg=251                 "
    hi String           ctermfg=251                 "字串
    hi Character        ctermfg=251                 "字元
    hi Number           ctermfg=251                 "數字
    hi Boolean          ctermfg=251                 "true or false
    hi Float            ctermfg=251                 "浮點數

    hi Identifier       cterm=NONE ctermfg=251      "print in python, variable
    hi Function         ctermfg=172                 "function in python

    hi Statement        ctermfg=33                  "using, for, if, return
    hi Conditional      ctermfg=33                  "if else switch
    hi Repeat           ctermfg=33                  "for while do
    hi Label            ctermfg=33                  "case: default:
    hi Operator         ctermfg=251                 "- = ==
    hi Keyword          ctermfg=green
    hi Exception        ctermfg=33                  "try catch throw

    hi PreProc          ctermfg=33                  "#include, #define
    hi Include          ctermfg=33                  "#include
    hi Define           ctermfg=green
    hi Macro            ctermfg=172                 "#define
    hi PreCondit        ctermfg=33                  "#ifdef #endif

    hi Type             ctermfg=172                 "型態 int, char
    hi StorageClass     ctermfg=172                 "static const
    hi Structure        ctermfg=172                 "struct, class, typedef, namespace
    hi Typedef          ctermfg=green

    hi Special          ctermfg=172                 "Esc CR
    hi SpecialChar      cterm=bold ctermfg=160      "\n
    hi Tag              ctermfg=green
    hi Delimiter        ctermfg=251                 "(), <> for function
    hi SpecialComment   ctermfg=red
    hi Debug            ctermfg=9                   "echo debug

    hi Underlined       cterm=underline ctermfg=13

    hi Ignore           ctermfg=238

    hi Error            cterm=bold ctermfg=7 ctermbg=1

    hi Todo             cterm=bold ctermfg=135 ctermbg=NONE     "TODO, FIXME, XXX

    hi ColorColumn      cterm=reverse
    hi Conceal          cterm=reverse ctermfg=245 ctermbg=NONE
    hi Cursor           cterm=reverse
    hi CursorIM         cterm=reverse
    hi CursorColumn     cterm=reverse
    hi CursorLine       cterm=underline
    hi Directory        ctermfg=172                 "NERDtree 資料夾
    hi DiffAdd          ctermbg=4
    hi DiffChange       ctermbg=13
    hi DiffDelete       cterm=bold ctermfg=4 ctermbg=14
    hi DiffText         cterm=bold ctermbg=1
    hi ErrorMsg         cterm=bold ctermfg=7 ctermbg=1
    hi VertSplit        cterm=reverse
    hi Folded           ctermfg=darkgrey ctermbg=NONE
    hi FoldColumn       ctermfg=darkgrey ctermbg=NONE
    hi SignColumn       cterm=NONE ctermbg=NONE     "語法檢查通過行
    hi IncSearch        cterm=NONE ctermfg=yellow ctermbg=green
    hi LineNr           ctermfg=245                 "行號
    hi MatchParen       cterm=NONE ctermfg=0 ctermbg=11 "配對的括號
    hi ModeMsg          cterm=NONE ctermfg=brown
    hi MoreMsg          ctermfg=green
    hi NonText          cterm=NONE ctermfg=245      "最後一行以下的~
    hi Normal           ctermfg=251                 "其他內容
    hi Pmenu            cterm=reverse
    hi PmenuSel         cterm=reverse
    hi PmenuSbar        cterm=reverse
    hi PmenuThumb       cterm=reverse
    hi Question         ctermfg=green
    hi Search           cterm=NONE ctermfg=grey ctermbg=blue
    hi SpecialKey       ctermfg=245                 "對齊符號
    if has("spell")
        hi SpellBad    guisp=#FF0000 gui=undercurl
        hi SpellCap    guisp=#7070F0 gui=undercurl
        hi SpellLocal  guisp=#70F0F0 gui=undercurl
        hi SpellRare   guisp=#FFFFFF gui=undercurl
    endif
    hi StatusLine       cterm=bold
    hi StatusLineNC     cterm=reverse
    hi TabLine          cterm=reverse
    hi TabLineFill      cterm=reverse
    hi TabLineSel       cterm=reverse
    hi Title            ctermfg=13
    hi Visual           cterm=bold,reverse          "選取
    hi VisualNOS        cterm=bold,underline
    hi WarningMsg       ctermfg=1
    hi WildMenu         ctermfg=0 ctermbg=11

    "":let c_comment_strings = 1
    ""hi c_comment_strings guisp=#FFFFFF
endif
"vim: sw=4
