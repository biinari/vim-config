" personal filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ldf setfiletype tex
  au! BufRead,BufNewFile *.ly,*.ily setfiletype lilypond
  au! BufRead,BufNewFile *.htc setfiletype javascript
  au! BufRead,BufNewFile */db/structure.sql setfiletype pgsql
  au! BufRead,BufNewFile *.sql setfiletype mysql
  au! BufRead,BufNewFile *.pkg,*.cls,*.proc	setfiletype docbk
  au! BufRead,BufNewFile *.pp setfiletype puppet
  au! BufRead,BufNewFile *.hsc setfiletype haskell
  au! BufRead,BufNewFile *.sass setfiletype sass
  au! BufRead,BufNewFile *.tpl setfiletype smarty
  au! BufRead,BufNewFile capfile,Capfile,Guardfile,Vagrantfile,Berksfile,*.thor setfiletype ruby
  au! BufRead,BufNewFile */system/apache2/* setfiletype apache
  au! BufRead,BufNewFile */crontabs/* setfiletype crontab
  au! BufRead,BufNewFile *.md,*.markdown setfiletype ghmarkdown
  au! BufRead,BufNewFile *.coffee setfiletype coffee
  au! BufRead,BufNewFile *.fdoc,*.fdoc.* setfiletype yaml
  au! BufRead,BufNewFile *.rdoc setfiletype rdoc
  au! BufRead,BufNewFile *.slim setfiletype slim
  au! BufRead,BufNewFile */.bundle/config setfiletype yaml
  au! BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
  au! BufRead,BufNewFile haproxy.cfg setfiletype haproxy
  au! BufRead,BufNewFile *.{mustache,handlebars,hbs,hogan,hulk,hjs}{,.erb} set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au! BufRead,BufNewFile /etc/systemd/system/*/*.conf setfiletype systemd
  au! BufRead,BufNewFile *.json,*.jsonp setfiletype json
augroup END
