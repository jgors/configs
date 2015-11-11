" vim colorscheme
" Created by Jason Gors
" Created 2009
"
" like_jazz.vim
" ========================
"

set background=light

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "like_jazz"

" Global
" normal is the background color
"hi Normal               guifg=#000000       guibg=#ffffff
hi Normal                guifg=Black         guibg=grey97
"hi Normal                guifg=Black         guibg=WhiteSmoke
"hi Normal                guifg=Black         guibg=DarkSlateGray1
"hi Normal                guifg=Black         guibg=CadetBlue1
"hi Normal                guifg=Black         guibg=seashell1
"hi Normal                guifg=Black         guibg=snow2
"hi Normal                guifg=Black         guibg=LightCyan


"hi NonText              guifg=#438ec3       guibg=gray90
" from chela_light:
"hi normal               guifg=#000000       guibg=#fafafa   gui=none
"hi nontext              guifg=#999999       guibg=#fafafa   gui=none

" Search
hi Search               guifg=Black         guibg=Yellow
hi IncSearch            guifg=#708090       guibg=#f0e68c

" Interface Elements
hi StatusLine           guifg=#ffffff       guibg=#43c464   gui=bold
hi StatusLineNC         guifg=#9bd4a9       guibg=#51b069
hi VertSplit            guifg=#3333ff       guibg=#3333ff   gui=none
hi Folded               guifg=#3c78a2       guibg=#c3daea
"hi Pmenu                guifg=#ffffff       guibg=#cb2f27
hi WildMenu             guifg=#ffffff       guibg=#339900   gui=none
hi SignColumn                               guibg=#1b5c8a
"hi CursorLine                               guibg=#eff2f4
hi CursorLine                               guibg=gray90
hi LineNr               guifg=Gray
hi MatchParen           guifg=Blue          guibg=lightgreen

" Specials
"hi Todo                 guifg=#e50808       guibg=#dbf3cd   gui=bold
hi ToDo                 guifg=Blue          guibg=Green     gui=none
hi Title                guifg=#000000                       "gui=bold
hi Special              guifg=#fd8900

" Syntax Elements
hi Conditional          guifg=DarkViolet                    gui=bold
hi String               guifg=Red
hi Number               guifg=DarkBlue
hi Constant             guifg=#0086d2
hi Statement            guifg=Blue                          "gui=bold
hi Function             guifg=Magenta                       "gui=bold


"hi Comment              guifg=#228b22       guibg=Grey96    gui=italic
"hi Comment              guifg=#339900       guibg=Grey96    gui=italic
" from chela_light:
"hi Comment              guifg=#339900       guibg=#fafafa   gui=italic
"
"hi Comment              guifg=#339900       guibg=#fafafa
"hi Comment               guifg=#786000
hi Comment               guifg=#339900


" for ipython code in conque-term
"hi PreProc              guifg=#ff0007                       "gui=bold
hi PreProc              guifg=Blue                          "gui=bold
"
"for Exception handling:
hi Type                 guifg=DarkRed                        gui=underline

hi Error                guifg=#ffffff       guibg=#d40000
"hi Identifier           guifg=#ff0086                       gui=bold
hi Identifier           guifg=NavyBlue                       "gui=bold
hi Label                guifg=#ff0086

" Python Highlighting
"hi pythonBuiltin        guifg=DarkSlateBlue
hi pythonCoding         guifg=#ff0086
hi pythonRun            guifg=#ff0086
hi pythonBuiltinObj     guifg=#2b6ba2                       gui=bold
hi pythonBuiltinFunc    guifg=#2b6ba2                       gui=bold
hi pythonException      guifg=#ee0000                       gui=bold
hi pythonExClass        guifg=#66cd66                       gui=bold
"hi pythonSpaceError                         guibg=#f8e6e6
hi pythonDocTest        guifg=#2f5f49
hi pythonDocTest2       guifg=#3b916a
"hi pythonFunction       guifg=#ee0000                       "gui=bold
hi pythonFunction       guifg=DarkGreen                     "gui=bold
hi pythonClass          guifg=#ff0086                       gui=bold

" HTML Highlighting
"hi htmlTag              guifg=#00bdec                       gui=bold
"hi htmlEndTag           guifg=#00bdec                       gui=bold
hi htmlTag              guifg=Blue                          gui=bold
hi htmlEndTag           guifg=Blue                          gui=bold
hi htmlSpecialTagName   guifg=#4aa04a
hi htmlTagName          guifg=#4aa04a
hi htmlTagN             guifg=#4aa04a
