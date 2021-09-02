"set binary " fix dos files to unix
set mouse=a
set shiftwidth=2
set tabstop=2
set shiftround
set autoindent
set expandtab
set smarttab
set scrolloff=4
set scrollopt="ver,hor,jump"
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=o " Do not insert a comment leader on pressing 'o' or 'O' in normal mode
set fo-=j " Remove a comment leader when joining lines
"set nosmartindent
"inoremap # X#
set nohlsearch
set noincsearch
set formatoptions+=j
set showcmd
set sidescroll=8
set laststatus=1

" Put swap files in ~/tmp using whole path name (replacing / with %)
set dir=~/tmp//,/var/tmp//,/tmp//

" Line break on words with a highlighted marker
"let &showbreak = '| '
"set lbr

" Default javascript checkers
let g:syntastic_javascript_checkers = ['eslint']

function! EnableBladeTags()
  " blade.php open / close tags
  if (exists("php_parent_error_open") && php_parent_error_open)
    syn region phpRegion matchgroup=Delimiter start="@php" end="@endphp" contains=@phpClTop
  else
    syn region phpRegion matchgroup=Delimiter start="@php" end="@endphp" contains=@phpClTop keepend
  endif
endfunction

augroup vimrc
  " Remove all autocommands previously set by vimrc
  autocmd!
  autocmd BufEnter *.py setl et ts=4 sw=4
  "autocmd BufEnter *.py inoremap # X#
  autocmd BufEnter *.rb,Capfile,capfile,Guardfile,Rakefile,*.thor,Vagrantfile setl et ts=2 sw=2
  autocmd BufEnter *.fdoc,*.fdoc.*,*.yml,*/.bundle/config setl et ts=2 sw=2 indentexpr= indentkeys=

  autocmd BufEnter *.coffee setl et ts=4 sw=4
  autocmd BufEnter *.sass setl et ts=2 sw=2
  autocmd BufEnter *.html setl et ts=2 sw=2
  autocmd BufEnter *.tpl setl et ts=2 sw=2
  autocmd BufEnter *.erb setl et ts=2 sw=2
  autocmd BufEnter *.php,*.inc setl noet ts=4 sw=4 indentexpr= indentkeys= ai si
  autocmd BufEnter *.blade.php setl et ts=2 sw=2 indentexpr= indentkeys= ai si
  autocmd BufEnter *.cc,*.c,*.h setl et ts=4 sw=4
  autocmd BufEnter *.md setl et ts=4 sw=4
  autocmd BufEnter *.go setl noet ts=4 sw=4
  autocmd BufEnter Makefile setl noet ts=4 sw=4
  autocmd BufWritePost *.go silent !go fmt %
  " PKGBUILD expect SC2034 unused variables
  " SC2154 unassigend variables (srcdir,pkgdir)
  " SC2164 cd to known good path
  " SC2016 expressions in single quotes in sed patterns
  autocmd BufEnter PKGBUILD let g:syntastic_sh_shellcheck_args = "-s bash -e SC2034,SC2154,SC2164,SC2016"
  autocmd BufEnter *.install let g:syntastic_sh_shellcheck_args = "-s bash -e SC2154"

  autocmd BufWritePost *.tf,*.tfvars silent !$GOBIN/terraform fmt %
augroup END

set nocompatible " be iMproved
filetype off     " required by Vundle
if !has('nvim')
  set history=200
endif
set ruler        " Show the cursor position all the time
set showmatch    " Show matching brackets

set nowb         " disable backup
set nrformats=bin,octal,hex

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes+=.hi

"set guioptions-=T " disable the toolbar
set guioptions=aei " Autoselect, tab pages, vim icon.
let g:tex_flavor="latex"
if has('nvim')
  set guifont=Monospace:h8
else
  set guifont=Monospace\ 8
endif
set background=dark

syntax on
colorscheme koehler
" dark:  candycode fruity koehler motus tango torte
" light: sienna tolerable

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
  call vundle#begin()

  " let Vundle manage Vundle
  " required by Vundle
  Plugin 'gmarik/vundle'

  " original repos on github
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-rhubarb'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'tpope/vim-bundler'
  Plugin 'tpope/vim-rails.git'
  Plugin 'tpope/vim-rake.git'
  "Plugin 'tpope/vim-projectionist.git'
  Plugin 'othree/html5.vim'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'cakebaker/scss-syntax.vim'
  Plugin 'tpope/vim-haml'
  "Plugin 'rodjek/vim-puppet'
  "Plugin 'joonty/vdebug'
  Plugin 'jtratner/vim-flavored-markdown'
  Plugin 'slim-template/vim-slim'
  Plugin 'StanAngeloff/php.vim'
  Plugin 'jwalton512/vim-blade'
  Plugin 'exu/pgsql.vim'
  Plugin 'mustache/vim-mustache-handlebars'
  Plugin 'scrooloose/syntastic'
  Plugin 'elzr/vim-json'
  "Plugin 'evidens/vim-twig'
  "Plugin 'tmatilai/vim-monit'
  Plugin 'derekwyatt/vim-scala'
  Plugin 'smerrill/vcl-vim-plugin'
  "Plugin 'elixir-lang/vim-elixir'
  Plugin 'hashivim/vim-terraform'
  Plugin 'fatih/vim-go'
  "Plugin 'leafgarland/typescript-vim'
  Plugin 'ajorgensen/vim-markdown-toc'

  " vim-scripts repos
  "Plugin 'L9'
  Plugin 'smarty-syntax'
  Plugin 'matchit.zip'
  "Plugin 'RDoc'
  Plugin 'nginx.vim'
  Plugin 'haproxy'
  Plugin 'Jinja'

  call vundle#end() " required by Vundle
  if s:hasVundle == 0
      echo "Installing Plugins, please ignore key map error messages"
      echo ""
      :PluginInstall
      let s:hasVundle=1
  endif
endif
filetype plugin indent on " required by Vundle

"let php_sql_query = 1
"let php_html_in_strings = 1
let php_folding = 3
let php_nested_functions = 1

" php highlighting
hi phpRelation guifg=DarkRed ctermfg=DarkRed
hi phpSuperglobal guifg=SlateBlue ctermfg=DarkBlue
hi String guifg=#cc33ee ctermfg=DarkMagenta

" let go_highlight_array_whitespace_error = 0
" let go_highlight_chan_whitespace_error = 0
let go_highlight_trailing_whitespace_error = 0

hi DiffText term=reverse cterm=bold ctermbg=0 gui=bold guibg=Red guifg=Black ctermfg=White

hi link jsonKeyword Identifier

let Grep_Skip_Dirs='.svn'
let Grep_Skip_Files='*.bak *~ *.swp'

"set title
"set titlestring=%t " Set Window title to reflect filename (was %F)
if has('nvim')
  "set titlestring=%f %m
  set title
endif

" Tags
map <F8> :!/usr/bin/ctags -R --fields=+iaS --extra=+q --exclude="*.js" --exclude="*.sql" --exclude="vendor" --exclude="blog" .<CR>

" JSON
let g:vim_json_syntax_conceal = 0

" Syntastic lint and style checkers
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': ['ruby', 'javascript', 'php', 'css', 'scss', 'sass', 'xml', 'python', 'yaml', 'json', 'sh', 'twig'] }

"let g:syntastic_ruby_mri_quiet_messages = {
"  \ 'regex': 'assigned but unused variable' }
let g:syntastic_ruby_rubocop_exec = '/usr/local/bin/rubocop'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_quiet_messages = {
      \ 'regex': [
        \ 'Remove debugger entry point `binding.pry`'] }
let g:syntastic_ruby_mri_quiet_messages = {
      \ 'regex': [
        \ 'assigned but unused variable'] }

"let g:syntastic_javascript_checkers = ['jsl']
"let g:syntastic_javascript_jsl_args = '-conf /etc/jsl.conf'

let g:syntastic_javascript_checkers = ['jscs', 'jshint']

let g:syntastic_sh_shellcheck_args = "-e SC2154"

function! Python2()
  let g:syntastic_python_python_exec='/usr/bin/python2'
  let g:syntastic_python_pylint_exec='/usr/bin/pylint2'
  let g:syntastic_python_pylint_args='-E --rcfile=/home/bill/.pylintrc'
endfunction
command! -nargs=0 -complete=command Python2 call Python2()
function! Python3()
  let g:syntastic_python_python_exec='/usr/bin/python3'
  let g:syntastic_python_pylint_exec='/usr/bin/pylint3'
endfunction
command! -nargs=0 -complete=command Python3 call Python3()
call Python3()

let g:syntastic_css_csslint_args='--ignore=adjoining-classes,important,overqualified-elements,compatible-vendor-prefixes,ids,order-alphabetical,qualified-headings,unique-headings'

let g:syntastic_scss_checkers = ['sass_lint']

let g:syntastic_c_include_dirs = ['includes', 'headers', '/usr/include/xorg', '/usr/include/pixman-1']
let g:syntastic_c_checkers = ['gcc', 'cppcheck']

let g:syntastic_html_checkers = ['w3']

let g:syntastic_yaml_jsyaml_quiet_messages = {
      \ 'regex': [
        \ 'unknown tag !<!ruby/\(object:\(\w\|:\)*\|regexp\)>'] }

nmap <C-s> :SyntasticCheck<CR>
nmap <M-s> :SyntasticReset<CR>
nmap <M-h> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
  \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:go_fmt_autosave = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

function! ToggleMaxHeight()
  if &lines > 24
    set lines=23
  else
    if has("gui_running")
      set lines=999
    else
      set lines=53
    endif
  endif
endfunction
function! ToggleMaxWidth()
  if &columns > 80
    set columns=80
  else
    if has("gui_running")
      set columns=999
    else
      set columns=191
    endif
  endif
endfunction
map <M-PageUp> :call ToggleMaxHeight()<CR>
map <M-PageDown> :call ToggleMaxWidth()<CR>

if exists("g:vdebug_options")
  let g:vdebug_options = { 'continuous_mode': 1 }
endif
