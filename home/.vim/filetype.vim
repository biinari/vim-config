" personal filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ldf	setfiletype tex
  au! BufRead,BufNewFile *.ly,*.ily	setfiletype lilypond
  au! BufRead,BufNewFile *.htc	setfiletype javascript
  au! BufRead,BufNewFile *.sql	setfiletype mysql
  au! BufRead,BufNewFile *.pkg,*.cls,*.proc	setfiletype docbk
  au! BufRead,BufNewFile Vagrantfile setfiletype ruby
  au! BufRead,BufNewFile *.pp setfiletype puppet
  au! BufRead,BufNewFile *.hsc setfiletype haskell
  au! BufRead,BufNewFile *.sass setfiletype sass
  au! BufRead,BufNewFile *.tpl setfiletype smarty
augroup END
