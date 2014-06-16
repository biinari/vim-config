"set binary " fix dos files to unix
set mouse=a
set shiftwidth=2
set tabstop=2
set shiftround
set autoindent
set expandtab
set smarttab
set scrolloff=4
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=o " Do not insert a comment leader on pressing 'o' or 'O' in normal mode
set fo-=j " Remove a comment leader when joining lines
"set nosmartindent
"inoremap # X#

autocmd BufEnter *.py setl et ts=4 sw=4
"autocmd BufEnter *.py inoremap # X#
autocmd BufEnter *.rb,Capfile,capfile,Guardfile,Rakefile,*.thor,Vagrantfile setl et ts=2 sw=2
autocmd BufEnter *.fdoc,*.fdoc.*,*.yml,*/.bundle/config setl et ts=2 sw=2 indentexpr= indentkeys=

autocmd BufEnter *.coffee setl et ts=4 sw=4
autocmd BufEnter *.sass setl et ts=2 sw=2
autocmd BufEnter *.html setl et ts=2 sw=2
autocmd BufEnter *.tpl setl et ts=2 sw=2
autocmd BufEnter *.erb setl et ts=2 sw=2
autocmd BufEnter *.php setl ts=4 sw=4 indentexpr= indentkeys= ai si

set nocompatible " be iMproved
filetype off     " required by Vundle
set history=50   " keep 50 lines of command history
set ruler        " Show the cursor position all the time
set showmatch    " Show matching brackets

set nowb         " disable backup

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes+=.hi

"set guioptions-=T " disable the toolbar
set guioptions=aei " Autoselect, tab pages, vim icon.
let g:tex_flavor="latex"
set guifont=Monospace\ 9

syntax on
set background=dark
colorscheme default
hi comment guifg=blue ctermfg=blue

set runtimepath+=/usr/share/lilypond/2.12.2/vim/

if !exists('s:includedVundle')
  let s:includedVundle = 1
  let s:hasVundle=1
  let s:vundle_readme=expand('~/.vim/bundle/vundle/README.md')
  if !filereadable(s:vundle_readme)
      echo "Installing Vundle..."
      echo ""
      silent !mkdir -p ~/.vim/bundle
      silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
      let s:hasVundle=0
  endif
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let Vundle manage Vundle
  " required by Vundle
  Bundle 'gmarik/vundle'

  " original repos on github
  Bundle 'tpope/vim-fugitive'
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-rails.git'
  Bundle 'tpope/vim-rake.git'
  Bundle 'othree/html5.vim'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'cakebaker/scss-syntax.vim'
  Bundle 'tpope/vim-haml'
  Bundle 'rodjek/vim-puppet'
  Bundle 'joonty/vdebug'
  Bundle 'jtratner/vim-flavored-markdown'
  Bundle 'slim-template/vim-slim'
  Bundle 'StanAngeloff/php.vim'
  Bundle 'exu/pgsql.vim'
  Bundle 'mustache/vim-mustache-handlebars'
  " vim-scripts repos
  Bundle 'L9'
  Bundle 'smarty-syntax'
  Bundle 'matchit.zip'
  Bundle 'RDoc'
  Bundle 'bundler'
  Bundle 'nginx.vim'
  Bundle 'haproxy'

  if s:hasVundle == 0
      echo "Installing Bundles, please ignore key map error messages"
      echo ""
      :BundleInstall
  endif
endif

"let php_sql_query = 1
"let php_html_in_strings = 1
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

filetype plugin indent on   " required by Vundle

" Tags
map <F8> :!/usr/bin/ctags -R --fields=+iaS --extra=+q --exclude="*.js" --exclude="vendor" --exclude="blog" .<CR>
