set nocompatible                    " not vi compatible; must be 1st
set nomodeline                      " disable mode lines


"""""""""""""""""""""""""""""""""""
" Vundle
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" load the bundles/plugins
source ~/.configs/.vim/vundle_bundles.vim
"""""""""""""""""""""""""""""""""""


filetype plugin indent on           " allows use of plug-ins and such
syntax on
syntax enable
"set smartindent                    " instead of these 2, using the google code below (smartindent doesn't play nice w/ python)
set autoindent                      " copy indent from current line when starting a new line
set shiftwidth=4                    " # of spaces to use for autoindent
set tabstop=4                       " makes tabs 4 spaces instead of 8
set expandtab                       " turns tab in insert mode into appropriate # of spaces
set smarttab                        " insert tabs on the beg of line according to shiftwidth, not tabstop
set shiftround                      " use shiftwidth size for shifting code with '<' &/or '>'
set softtabstop=4                   " when hitting <BS>, act like a tab is removed
set backspace=eol,start,indent      " allow backspacing over everything
set scrolloff=2                     " keep n # of lines off of the top/bottom edges when vertical scrolling
set sidescrolloff=10                " how close to get to the screen edge before it scrolls horizontally
set sidescroll=1                    " along w/ sidescrolloff, makes scrolling horizontally smoother
set nowrap                          " don't line wrap text if it stretches past the window edge
"set showbreak=↪                    " put at the start of lines that have been wrapped
"set textwidth=100                  " break lines when line length is too long
"set colorcolumn=90                 " show colored column when a line of code is too long
"if exists("&colorcolumn")          " have color column warn after 90 characters only in insert mode
    "autocmd InsertEnter * set colorcolumn=91
    "autocmd InsertLeave * set colorcolumn=""
"endif
set nostartofline                   " stop certain movements from going to 1st char of line
set title                           " display window title
set number                          " display line numbers
"set relativenumber                  " set line numbers relative to where currently at
set belloff=all                     " no beeps or flashes
set ruler                           " display cursor position
set showmode                        " show current mode
set showcmd                         " show (partial) cmd & visual selection
set cmdheight=2                     " cmd win height to 2 lines
set laststatus=2                    " always display status line
set mousehide                       " hide mouse after typing something
set mouse=a                         " enable mouse in all modes
set go+=b                           " add bottom scrollbar (gvim)
set history=1000                    " remember more commands and search history
set undolevels=1000                 " max number of changes that can be undone
set viminfo='20,\"80                " read/write a .viminfo file & don't store more than 80 lines of registers
set nobackup                        " forbid vim to write a backup...
set noswapfile                      " ...or swap file
set backup                          " enable backups
set backupdir=/tmp                  " backup location
set backupskip=/tmp/*
set directory=/tmp                  " swap files
set undofile                        " create .un~ files; contain undo info, even after reopening file.
set undodir=~/.vim/undodir          " for undo files
set autochdir                       " automatically change wins cwd to the current file's dir (for gvim)
set autowrite                       " write the contents, if the file has been modified
set autoread                        " if a file has been changed outside of Vim & has not been changed
                                    " inside of Vim, automatically read it again.
set encoding=utf-8
set ttyfast                         " indicates a fast terminal connection


" F9 creates a word processing(ish) mode
" setlocal so it doesn't affect new buffers/tabs i open
func! DocumentEditingMode()
    "setlocal formatoptions+=tc1
    setlocal formatoptions=1
    "set formatprg=par              " use par to format text with `gq` (need to install par)
    set complete+=s
    setlocal spell spelllang=en_us
    :hi SpellBad ctermbg=LightMagenta
    :hi SpellCap ctermbg=LightBlue

    ":Relativity!
    "setlocal norelativenumber
    setlocal nonumber

    setlocal nocursorline    " turns off highlight of the current line
    setlocal smartindent
    setlocal noruler
    setlocal scrolloff=999   " stay in the middle when vertical scrolling

    :Goyo
    :Goyo 85%x90%
    setlocal linebreak  " break lines on words, not in the middle of them
    setlocal wrap
    "set tw=120   " break lines when line length is too long
    "set wrapmargin=10
    setlocal foldcolumn=5
    :hi FoldColumn ctermbg=NONE guibg=NONE

    " navigate misspelled words -- S goes to previous misspelled word, s goes to next one
    noremap S [s
    noremap s ]s
    " zg == to add current misspelled word to dict
    " z == gives a list of potential matches for a misspelled word
    noremap zz z=
endfu
nmap <silent> <F9> :call DocumentEditingMode()<CR>


" Tab completion settings for cmd window
set wildmenu                                    " make tab completion for files/buffers act like bash
set wildmode=longest,list,full                  " show a list when pressing tab and complete first full match
set wildignore=.swp,.bak,.pyc,*~                " ignore these file types
set wildignore+=.hg,.git                        " ...version cntrl
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png  " ...images
set wildignore+=*.avi,*.mov,*.mp3               " ...audio/vids
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar  " ...archive files
set wildignore+=*.DS_Store                      " ...OSX garbage


" Sudo writing
cmap w!! w !sudo tee % > /dev/null

" Write file (if changes has been made) and exit (a built-in cmd)
" :x

" Have ';' do the same thing as ':'
nnoremap ; :
" press ;; to get ;
noremap ;; ;

" Remaps <leader> from '\' to ','
let mapleader = ","

" Leave insert mode w/o developing rsi
inoremap jj <Esc>

" Move to beg of line (H) or end of line (L).
noremap H ^
noremap L g_

" If wrapping enabled, this solves the problem that moving around will jump the cursor over the line.
nnoremap j gj
nnoremap k gk

" Start at the last cursor position when (re)opening a file
autocmd BufReadPost *
        \ if line("'\"") > 1 && line ("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

" Source vimrc file after saving -- this breaks vim b/c of already
" defined funcs; leave commented out
"autocmd bufwritepost $HOME/.vimrc source $HOME/.vimrc

" might get rid of that black highlighting that shows up from time to time(?)
"nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

"Switch cwd to the dir of the open buffer
"map <leader>cd :cd %:p:h<cr>:pwd<cr>



" ---------------------------------------------------------------------------------------
" copy/paste

set clipboard+=unnamed              " copy/paste between vim sessions play nicer - yanks go to clipboard instead
"" Yank to the * register (* is into the system clipboard)
"noremap y "*y
"noremap y "+y
"" Paste from the * register (paste from the system clipboard)
"noremap p "*p
"noremap p "+p


" Line #s & fold column toggle
"
" Paste Mode
"
"" (for easier copy/pasting from terminal)
"nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

"" Disable autoindent to paste indented text.
set pastetoggle=<F2>

" Preserve indentation while pasting text from the clipboard
"noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

"Automatically jump to end of pasted text:
"paste multiple lines multiple times by pressing p
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" ---------------------------------------------------------------------------------------
" WINDOW Resizing
set noequalalways                   " wins are NOT automatically made the same size after splitting or closing a win

" decrease win height <shift>-
nmap _ <C-W>-

" increase win height <shift>=
nmap + <C-W>+

" decrease win width <shift>9
nmap ( <c-w><

" increase win width <shift>0
nmap ) <C-W>>

" ---------------------------------------------------------------------------------------
"  File specific
"
" Python
" Add header file for python files
"autocmd bufnewfile *.py so $HOME/.configs/.vim/py_header.txt
autocmd bufnewfile *.py 0r $HOME/.configs/.vim/py_header_new.txt

"autocmd bufnewfile *.py exe "1," . 10 . "g/Creation Date:.*/s//Creation Date: " .strftime("%m-%d-%Y")
autocmd bufnewfile *.py exe "1," . 9 . "g/Creation Date:.*/s//Creation Date: " .strftime("%m-%d-%Y")

autocmd Bufwritepre,filewritepre *.py execute "normal ma"
"autocmd Bufwritepre,filewritepre *.py exe "1," . 10 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
"autocmd bufwritepost,filewritepost *.py execute "normal `a"


" Remove extra whitespace when saving
"autocmd BufWritePre * :%s/\s\+$//<CR>:let @/=''<CR>
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

"autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" HTML
" Highlight code more nicely
"au BufReadPre *.html set filetype=htmlm4

" HTML
" Insert '<>' (in insert mode)
" <Control> y
"imap <silent> <C-y> <><ESC>i


" ---------------------------------------------------------------------------------------
" Mode Settings
set antialias

colorscheme like_jazz "colorscheme i made

"colorscheme chela_light
"colorscheme moria "not too bad
"colorscheme peaksea
"colorscheme PaperColor
"colorscheme cascadia
"colorscheme beauty256
"colorscheme bclear
"colorscheme pyte
"colorscheme hybrid
"colorscheme sol-term
"colorscheme Tomorrow


if has('gui_running')
    "set background=dark

    "colorscheme phd "darker theme
    "colorscheme iceberg "nice dark blue theme (only in gvim)
    "colorscheme materialbox "light theme (only in gvim)

    "FONTS
    if has("gui_macvim")
        set guifont=Inconsolata:h16
    else
        set guifont=Inconsolata\ 13
    endif

    " Different cursors for different modes.
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    "set guicursor+=i-ci:ver20-iCursor

else " Console Vim
    "set background=light

    "colorscheme like_jazz

    "FONTS
    "In console mode, Vim is uses the current font of the terminal;
    "so have to find out on the terminal profile & then modify it.

    " 3 plugins to make gvim colors work in the vim--colorsupport, csapprox, & guicolorscheme.
    " I'm using colorsupport.vim
    set t_Co=256                                        " so i can use colors in console

    " After startup stuff is loaded, then change the color of errors in PyFlakes:
    if &background == "dark"
        "autocmd VimEnter * :hi PyFlakes cterm=underline ctermbg=Red
        autocmd VimEnter * :hi PyFlakes ctermbg=Red
    else
        "autocmd VimEnter * :hi PyFlakes cterm=underline ctermbg=LightRed
        autocmd VimEnter * :hi PyFlakes ctermbg=LightMagenta
    endif
endif


" ---------------------------------------------------------------------------------------
" Status Line

"augroup ft_statuslinecolor
    "au!
    "au InsertEnter * hi StatusLine ctermfg=Black guifg=Black
    "au InsertLeave * hi StatusLine ctermfg=White guifg=White
"augroup END

"set statusline=%f                               " path.
"set statusline+=%m                              " modified flag.
"set statusline+=%r                              " read-only flag.
"set statusline+=%w                              " preview window flag.

"set statusline+=\                               " space.

""set statusline+=%#redbar#                       " highlight the following as a warning.
""set statusline+=%{SyntasticStatuslineFlag()}    " syntastic errors.
""set statusline+=%*                              " reset highlighting.
""
""let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'

"set statusline+=%=                              " right align.
"set statusline+=(
"set statusline+=%{&ft}                          " File type (python), (ruby), etc
"set statusline+=)

"" Line and column position, & counts.
""set statusline+=\ (line\ %l\/%L,\ col\ %03c)
"set statusline+=\ (Line:\ %l\/%L)
"set statusline+=\ (Buf:\ %n)
""set statusline+=[%b][0x%B]


"  _______POWERLINE _______
" (plugin for statusline; on by default)
"
"let g:Powerline_symbols = "unicode"

" ---------------------------------------------------------------------------------------
" Indenting Code
"
" <leader> h -- de-indent left
" <leader> l -- indent right

" Indent/unident block (,]) (,[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>

" Reselect visual selection after (de)indenting
vmap <leader>h <gv
vmap <leader>l >gv


" Indentation Guides
"
" (using Indentation Guide plug-in instead of this [see below])
" see :h listchars
"set list lcs=tab:┊\ ,precedes:«,extends:»
"autocmd! bufreadpost * set noexpandtab | retab! 4      " convert spaces to tabs when reading file
"autocmd! bufwritepre * set expandtab | retab! 4        " convert tabs to spaces before writing file
"autocmd! bufwritepost * set noexpandtab | retab! 4     " convert spaces to tabs after writing file (to show guides again)


" Indent Python in the Google way.
"setlocal indentexpr=GetGooglePythonIndent(v:lnum)
"let s:maxoff = 50 " maximum number of lines to look backwards.
"function GetGooglePythonIndent(lnum)
  "" Indent inside parens.
  "" Align with the open paren unless it is at the end of the line.
  "" E.g.
  ""   open_paren_not_at_EOL(100,
  ""                         (200,
  ""                          300),
  ""                         400)
  ""   open_paren_at_EOL(
  ""       100, 200, 300, 400)
  "call cursor(a:lnum, 1)
  "let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        "\ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        "\ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        "\ . " =~ '\\(Comment\\|String\\)$'")
  "if par_line > 0
    "call cursor(par_line, 1)
    "if par_col != col("$") - 1
      "return par_col
    "endif
  "endif

  "" Delegate the rest to the original function.
  "return GetPythonIndent(a:lnum)

"endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"


" ---------------------------------------------------------------------------------------
" Folding
"
" toggle all folds
map <leader>fa zi
" toggle folds around current block of code
map <leader>fb za

set foldmethod=indent           " folding based on indentation
"set foldlevelstart=10           " open most folds by default
set foldnestmax=2               " deepest folding is at N levels
set nofoldenable                " start w/ no folding
"set foldcolumn=1                " add a fold column (don't like this in tmux)

" ---------------------------------------------------------------------------------------

" Highlighting & Searching
"
" Highlight all occurrences of current word
nnoremap <leader>a :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Make better cursor
:highlight Cursor gui=NONE guifg=bg guibg=fg
set guicursor+=a:blinkon0                       " never blink cursor in gvim
set cursorline                                  " highlights the line currently on

" Search for function def currently under cursor
map <buffer> gd /def <c-r><c-w><cr>

" Use better regexes.
"nnoremap / /\v
"vnoremap / /\v

" incsearch, showmatch and hlsearch work together to highlight search results
set incsearch           " show search matches as you type
set showmatch           " show matching brackets
set hlsearch            " highlight search terms

set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase, case-sensitive otherwise
set showfulltag         " show full tags when doing search completion
set gdefault            " search/replace 'globally' (per line)
" because of this last setting, don't need to use g in string search and
" replaces (b/c g means global normally, but with 'set gdefault' on, g reverses its meaning)

" Clears search highlighting with <leader><space>
nnoremap <leader><space> :noh<cr>

" ---------------------------------------------------------------------------------------
" Window Tabs

set showtabline=1                   " when to start showing open tabs at the top of window

" To cycle through tabs
nnoremap <C-u> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>

" ---------------------------------------------------------------------------------------
" Buffers (splitting, moving, etc)

set hidden                          " current buffer can be hidden (put to bg) w/o being written

" Switch between current buffer and previous one
" <leader> <leader>
nnoremap <leader><leader> <c-^>

" Keep track of buffers and their respective #s for quick buffer switching
"nnoremap <leader>b :buffers<CR>:buffer<Space>
"
" same as above, but opens the selected buffer in split
nnoremap <leader>b :buffers<CR>:sbuffer<Space>
set switchbuf=useopen,usetab

" To cycle through buffers
"nnoremap <C-u> :bprevious<CR>
"nnoremap <C-n> :bnext<CR>

" <leader> t -- Open top to bottom (vert) split & switch to it.
" <leader> s -- Open side to side (horiz) split & switch to it.
nnoremap <leader>t <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
"set splitright                  " puts new vsplit windows to the right of the current
"set splitbelow                  " puts new split windows to the bottom of the current

" Maps <control-[h/j/k/l]> to move around buffer splits.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Close & Kill buffer (if there are multiple buffers in the same window);
" else, kill the window entirely if it's the last buffer in that window.
" <leader> q
function! CloseWindowOrKillBuffer()
  if(bufwinnr('%')) > 1
    wincmd c
  else
    bdelete
  endif
endfunction

nnoremap <silent> <leader>q :call CloseWindowOrKillBuffer()<CR>


"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"
"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"
"                                                                                       "
"------------------------------------  PLUG-INS  ---------------------------------------"
"                                                                                       "
"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"
"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"#"
"
" ctrlp.vim
" Full path fuzzy file, buffer and MRU finder
" https://github.com/kien/ctrlp.vim
"
let g:ctrlp_working_path_mode = 2 " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
"let g:ctrlp_split_window = 1 " <CR> = New Tab
let g:ctrlp_open_new_file = 1

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" tagbar.vim
" To see source code in side panel

"nmap <F4> :TagbarToggle<CR>

" Sort tags by order in file, not by alphabetical order
"let g:tagbar_sort = 0


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" EXECUTE CODE

" _______Entire File_______
" <leader-r>
autocmd FileType python nmap <buffer> <leader>r :w<cr>:!/usr/bin/env python % <cr>
autocmd FileType ruby nmap <buffer> <leader>r :w<cr>:!/usr/bin/env ruby % <cr>
autocmd FileType Rscript nmap <buffer> <leader>r :w<cr>:!/usr/bin/env Rscript % <cr>
" <leader-3> for python 3
"nmap <buffer> <leader>3 :w<cr>:!/usr/bin/env python3 % <cr>



" _______CONQUETERM_______
" Run terminal(/ ipython / zsh /etc) in a buffer split.

" Execute the current file in a new terminal buffer; will split the screen with a new
"       buffer -- the file must be executable for this to work.
"let g:ConqueTerm_ExecFileKey = '<leader>r'

" Send the entire contents of the file you are editing to an existing buffer.
" (run whole file)
"let g:ConqueTerm_SendFileKey = '<leader>r'

" Send visual mode highlighted code in buffer split.
" (execute only highlighted code)
let g:ConqueTerm_SendVisKey = '<leader>e'

" Sends "%cpaste" to ipython split -- <leader> cp
nnoremap <leader>cp :call conque_term#get_instance().writeln('%cpaste')<CR>

function MyConqueStartup(term)
    " Set buffer syntax using the name of the program currently running
    let syntax_associations = { 'ipython': 'python', 'irb': 'ruby' }
    if has_key(syntax_associations, a:term.program_name)
        execute 'setlocal syntax=' . syntax_associations[a:term.program_name]
    else
        execute 'setlocal syntax=' . a:term.program_name
    endif
endfunction
" After a call to start a conqueterm is sent, then do this function is executed
call conque_term#register_function('after_startup', 'MyConqueStartup')

" environment specific buffer set-ups
map <leader>ip :call conque_term#open('ipython', ['below split', 'resize 15'], 0)<cr>
map <leader>i3 :call conque_term#open('ipython3', ['below split', 'resize 15'], 0)<cr>
map <leader>sh :call conque_term#open('zsh', ['below split', 'resize 15'], 0)<cr>
map <leader>rs :call conque_term#open('R', ['below split', 'resize 20'], 0)<cr>



" _______VIMUX_______

"map <Leader>vip :call MyVimuxEnvir("ipy")<CR>
"map <Leader>vr :call MyVimuxEnvir("r")<CR>

"function! MyVimuxEnvir(environ)

    "" Run a visual highlighted chunk of code in the vimux split
    "vmap <silent> <Leader>e :python run_visual_code()<CR>

    "" Execute cell & decide whether to leave cursor at point of execution
    ""noremap <silent> <Leader>c :python run_cell(save_position=False)<CR>
    "noremap <silent> <Leader>c :python run_cell(save_position=False, cell_delim='# <codecell>')<CR>

    "" Open a split with ipython [R, etc] by running the approp function
    "if a:environ == 'ipy'
        ""call VimuxIpy()
        "call VimuxIpy("ipython --pylab")
        ""call VimuxIpy("ipython --profile=ssh")
        ""probably don't start ipython inside tmux like this:
        ""call VimuxIpy("ipcluster start --profile=ssh &; ipython --profile=ssh")

    "elseif a:environ == 'r'
        "call VimuxR()

    "endif
"endfunction



" This part below was before i created the ipy and r vimux plugins
"map <Leader>vip :call MyVimux("ipy")<CR>
"map <Leader>vr :call MyVimux("r")<CR>

"function! MyVimux(environ)

    "" Open a split
    ""map <Leader>vc :call VimuxRunCommand("clear; ipython")<CR>

    "" Prompt for a command to run
    ""map <Leader>vp :VimuxPromptCommand<CR>

    "" Run last command executed by VimuxRunCommand
    ""map <Leader>vl :VimuxRunLastCommand<CR>

    "" Inspect runner pane (jump down into the pane) in vim mode
    "map <Leader>vi :VimuxInspectRunner<CR>

    "" Close all other tmux panes in current window
    "map <Leader>vx :VimuxClosePanes<CR>

    "" Close vim tmux runner opened by VimuxRunCommand
    "map <Leader>vq :VimuxCloseRunner<CR>

    "" Interrupt any command running in the runner pane
    "map <Leader>ve :VimuxInterruptRunner<CR>

    "" If text is selected, save it in the v buffer and send that buffer it to tmux
    ""vmap <Leader>vs "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
    ""vmap <leader>vs "0y :call VimuxRunCommand(@" . "\n", 0)<cr>
    ""vmap <Leader>vs "0y :call VimuxRunCommand(@", 0)<CR>

    "" Change pane height
    "let g:VimuxHeight = "35"

    "" Open a split with ipython [R, etc] by running the function
    "if a:environ == 'ipy'

        "" ___Vimux-ipy___

        "" Run a visual highlighted chunk of code in the vimux split
        "vmap <silent> <Leader>e :python run_tmux_python_chunk()<CR>

        "" Execute cell & then move cursor down to execute next cell
        ""noremap <silent> <C-b> :python run_tmux_python_cell(save_position=False)<CR>

        "" Execute cell & leave cursor at point of execution
        "noremap <silent> <Leader>c :python run_tmux_python_cell(save_position=True)<CR>

        ""exec VimuxRunCommand("clear; ipython --pylab")
        "exec VimuxRunCommand("clear; ipython")

    "" couldn't get this to work
    "elseif a:environ == 'r'
        "" Run a visually highlighted chunk of code in the vimux split
        "vmap <leader>e "0y :call VimuxRunCommand(@" . "\n", 0)<cr>

        "exec VimuxRunCommand("clear; R")

    "endif
"endfunction


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" NERDTREE
"
" Visual file browser
"noremap <silent> <leader>nt :NERDTreeToggle<CR>
" show me the hidden files as well.
let NERDTreeShowHidden=1
"let NERDTreeWinSize=25

" Instead of just plain nerdtree, use this:
" USE NERDTREE along with VIM-NERD-TREE-TABS to open nerdtree in all tabs at once
noremap <Leader>nt :NERDTreeTabsToggle<CR>
" find currently opened file and jump to it in nerdtree pane
noremap <Leader>nf :NERDTreeTabsFind<CR>
" don't open NERDTree on gvim startup
let g:nerdtree_tabs_open_on_gui_startup=0

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" INDENTATION HIGHLIGHTING GUIDE
"
" <leader> ig
"
"let g:indent_guides_enable_on_vim_startup = 1

" Sets indent highlighting to one column instead of 4 (only work for spaces, not tabs):
let g:indent_guides_guide_size = 1

" Indent level to start showing guides from:
let g:indent_guides_start_level = 2

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" MRU.vim

" Shows recently edited files
" gvim --> 'File -> Recent Files' (drop down menu)
" vim -->  ':MRU' command displays the MRU file list in a preview window
"
"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" ERROR CHECKING
"
"
" _______Pylint _______ ----------------------------------------------uninstalled
"
"autocmd FileType python compiler pylint
"let g:pylint_show_rate = 0 " to avoid code rate calculation


" _______PyFlakes_______
"
" (turned on by default)
" shows errors before run time


" _______Syntastic_______ ----------------------------------------------uninstalled
"
" (ssh issues)
"
" To use the |:sign| interface to mark syntax errors:
"let g:syntastic_enable_signs=1

" To make the cursor jump to the 1st error when saving or opening a file:
"let g:syntastic_auto_jump=0

" To use syntax highlighting to mark errors:
"let g:syntastic_enable_highlighting = 1

" If want syntax errors, not warnings:
"let g:syntastic_quiet_warnings=1
"
"let g:syntastic_check_on_open = 1


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" VIEWING PYTHON DOCUMENTATION

" pydoc.vim
" Python documentation view & search tool
"
" View documentation of the 'word' (see :help word) under the cursor by:
" <leader>pw    (same as K)
"
" Or the 'WORD' (see :help WORD) under the cursor by pressing
" <leader>pW

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" CODE COMPLETION


" _______omni-code completion_______
"
" (Needs to be turned on for supertab)
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"set ofu=syntaxcomplete#Complete
" Rebind code completion to CTRL+Space
"inoremap <C-Space> <C-x><C-o>


" _______supertab_______
"
"let g:SuperTabDefaultCompletionType = "context"    "keep this off so jedi plays nicer
"let g:SuperTabLongestEnhanced = 1
"let g:SuperTabLongestHighlight = 1



" _____jedi completion_____ " this is the one i'm currently using w/ supertab

"let g:jedi#auto_initialization = 0
"let g:jedi#popup_on_dot = 0
"let g:jedi#show_function_definition = "0"



" ________ycm________
"let g:ycm_complete_in_comments = 1
"let g:ycm_seed_identifiers_with_syntax = 1

""""" For preview window pop up:
" auto-close preview window after you select a completion string
"let g:ycm_autoclose_preview_window_after_completion = 1

" close the preview window after leaving insert mode
"let g:ycm_autoclose_preview_window_after_insertion = 1

" if never want preview window to show up
"set completeopt-=preview
"g:ycm_add_preview_to_completeopt = 0
"""""


" _______pydiction_______ ------------------------------------------------uninstalled
"
"let g:pydiction_location = '~/.vim/plugin/pydiction-1.2/complete-dict'


" _______Neocomplcache_______ --------------------------------------------uninstalled


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
" NERDCOMMENTER

" See docs for much more use info
" <leader>cc        comment code
" <leader>cu        uncomment code

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
"
"  SCRATCH BUFFER
" :SB or :ScratchToggle

map <Leader>sb :call ScratchToggle()<CR>

"command! SB call ScratchToggle()
function! ScratchToggle()
    exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
    let w:is_scratch_window = 1
endfunction

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" Gundo (undoing)
nnoremap <F5> :GundoToggle<CR>
let g:gundo_right = 1


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" Showmarks
"
" set a mark by pressing m followed by another letter/number that designates the mark. To jump to
" a mark, enter ' followed by the mark's letter/number.
"
" <Leader>mt   - Toggles ShowMarks on and off.
" <Leader>ma   - Clears all marks in the current buffer.
"let showmarks_enable=0
"let g:showmarks_include="abcdefghijklmnopqrstuvwxyz"
"let g:showmarks_textlower="|"

"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" Startify


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
xmap <leader>e <Plug>SlimeRegionSend
"let g:slime_paste_file = "/tmp/.slime_paste"


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" vim-relativity (using this instead of the func below)
"let g:relativity_insert_toggle = 0

" toggle between number and relativenumber
"function! ToggleNumber()
    "if(&relativenumber == 1)
        "set norelativenumber
        "set number
    "else
        "set relativenumber
    "endif
"endfunc
"nmap <silent> <F3> :call ToggleNumber()<CR>


"#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
" gutentags
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir="/tmp"
" ctrl-] to go to tag def if only one match or list all if many matches are found
noremap <C-]> g<C-]>
