set mouse=a
set shiftwidth=4
set tabstop=4
set shiftround
set autoindent
set expandtab
set smarttab
set scrolloff=5
"set nosmartindent
"inoremap # X#

autocmd BufEnter *.py setl shiftwidth=4 tabstop=4 expandtab
"autocmd BufEnter *.py inoremap # X#

autocmd BufEnter *.coffee setl et ts=4 sw=4
autocmd BufEnter *.sass setl et ts=2 sw=2

set nocompatible	" Use Vim defaults
set history=10		" keep 10 lines of command history
set ruler			" Show the cursor position all the time
set showmatch		" Show matching brackets

set nowb			" disable backup

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes+=.hi

"set guioptions-=T	" disable the toolbar
set guioptions=aei	" Autoselect, tab pages, vim icon.
let g:tex_flavor="latex"
set guifont=Monospace\ 9

syntax on
set background=dark
colorscheme default
hi comment	guifg=blue	ctermfg=blue

set runtimepath+=/usr/share/lilypond/2.12.2/vim/

let php_sql_query = 0
let php_htmlInStrings = 0
let php_folding = 3
let php_nested_functions = 1

hi phpRelation guifg=DarkRed ctermfg=DarkRed
hi phpSuperglobal guifg=SlateBlue ctermfg=DarkBlue
hi String guifg=#cc33ee ctermfg=DarkMagenta

hi DiffText term=reverse cterm=bold ctermbg=0 gui=bold guibg=Red guifg=Black ctermfg=White

let Grep_Skip_Dirs='.svn'
let Grep_Skip_Files='*.bak *~ *.swp'

"set title
"set titlestring=%t	" Set Window title to reflect filename (was %F)

filetype plugin on
