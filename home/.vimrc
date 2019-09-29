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

" Line break on words with a highlighted marker
"let &showbreak = '| '
"set lbr

autocmd BufEnter *.py setl et ts=4 sw=4
"autocmd BufEnter *.py inoremap # X#
autocmd BufEnter *.rb,Capfile,capfile,Guardfile,Rakefile,*.thor,Vagrantfile setl et ts=2 sw=2
autocmd BufEnter *.fdoc,*.fdoc.*,*.yml,*/.bundle/config setl et ts=2 sw=2 indentexpr= indentkeys=

autocmd BufEnter *.coffee setl et ts=4 sw=4
autocmd BufEnter *.sass setl et ts=2 sw=2
autocmd BufEnter *.html setl et ts=2 sw=2
autocmd BufEnter *.tpl setl et ts=2 sw=2
autocmd BufEnter *.erb setl et ts=2 sw=2
autocmd BufEnter *.php,*.inc setl ts=4 sw=4 indentexpr= indentkeys= ai si
autocmd BufEnter *.cc,*.c,*.h setl et ts=4 sw=4
autocmd BufEnter *.md setl et ts=4 sw=4
autocmd BufEnter *.go setl noet ts=4 sw=4
autocmd BufEnter PKGBUILD let g:syntastic_sh_checkers = ['sh']

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
set guifont=Monospace\ 8

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
  Bundle 'tpope/vim-bundler'
  Bundle 'tpope/vim-rails.git'
  Bundle 'tpope/vim-rake.git'
  Bundle 'tpope/vim-projectionist.git'
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
  Bundle 'scrooloose/syntastic'
  Bundle 'elzr/vim-json'
  Bundle 'evidens/vim-twig'
  Bundle 'tmatilai/vim-monit'
  Bundle 'derekwyatt/vim-scala'
  Bundle 'smerrill/vcl-vim-plugin'
  Bundle 'elixir-lang/vim-elixir'
  Bundle 'hashivim/vim-terraform'
  " vim-scripts repos
  Bundle 'L9'
  Bundle 'smarty-syntax'
  Bundle 'matchit.zip'
  Bundle 'RDoc'
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

filetype plugin indent on " required by Vundle

" Tags
map <F8> :!/usr/bin/ctags -R --fields=+iaS --extra=+q --exclude="*.js" --exclude="vendor" --exclude="blog" .<CR>

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

"let g:syntastic_javascript_checkers = ['jsl']
"let g:syntastic_javascript_jsl_args = '-conf /etc/jsl.conf'

let g:syntastic_javascript_checkers = ['jscs', 'jshint']

" Set tab-width for PHP_CodeSniffer based on current tabstop - not just at
" time of sourcing vimrc
function! SetPHPCSArgs()
  let g:syntastic_php_phpcs_args='--tab-width=' . &tabstop
  " To set indent open /usr/share/pear/PHP/CodeSniffer/Standards/Generic/Sniffs/WhiteSpace/ScopeIndentSniff.php and alter $indent (default 4)
endfunction
call SetPHPCSArgs()

let g:syntastic_php_phpcs_quiet_messages = {
      \ 'regex': [
        \ 'Language constructs must be followed by a single space; expected \\"\(require\|include\)\(_once\)\?',
        \ '\\"\(require\|include\)\(_once\)\?\\" is a statement not a function',
        \ 'This comment is \d*% valid code'] }

let g:syntastic_python_pylint_args='--rcfile=/home/bill/.pylintrc'

let g:syntastic_css_csslint_args='--ignore=adjoining-classes,important,overqualified-elements,compatible-vendor-prefixes,ids,qualified-headings,unique-headings'

let g:syntastic_scss_checkers = ['sass', 'scss_lint']
let g:syntastic_scss_scss_lint_quiet_messages = {
      \ 'regex': [
        \ 'Name of function `emCalc` should be written in lowercase with hyphens instead of underscores'] }

let g:syntastic_c_include_dirs = ['includes', 'headers', '/usr/include/xorg', '/usr/include/pixman-1']
let g:syntastic_c_checkers = ['gcc', 'cppcheck']

let g:syntastic_html_checkers = ['w3']

let g:syntastic_yaml_jsyaml_quiet_messages = {
      \ 'regex': [
        \ 'unknown tag !<!ruby/\(object:\(\w\|:\)*\|regexp\)>'] }

nmap <C-s> :call SetPHPCSArgs()<CR> :SyntasticCheck<CR>
nmap <M-s> :SyntasticReset<CR>
nmap <M-h> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
  \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

au! BufWrite *.php,*.inc call SetPHPCSArgs()

let g:vdebug_options = { 'continuous_mode': 1 }
