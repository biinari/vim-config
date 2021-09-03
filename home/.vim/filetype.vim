" personal filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ldf setfiletype tex
  au! BufRead,BufNewFile *.ly,*.ily setfiletype lilypond
  au! BufRead,BufNewFile *.htc setfiletype javascript
  au! BufRead,BufNewFile */db/structure.sql setfiletype pgsql
  au! BufRead,BufNewFile *.sql setfiletype pgsql
  au! BufRead,BufNewFile *.pkg,*.cls,*.proc	setfiletype docbk
  au! BufRead,BufNewFile *.pp setfiletype puppet
  au! BufRead,BufNewFile *.hsc setfiletype haskell
  au! BufRead,BufNewFile *.sass setfiletype sass
  au! BufRead,BufNewFile Appraisals,capfile,Capfile,Guardfile,Vagrantfile,Berksfile,*.thor setfiletype ruby
  au! BufRead,BufNewFile */system/apache2/* setfiletype apache
  au! BufRead,BufNewFile */crontabs/* setfiletype crontab
  au! BufRead,BufNewFile *.md,*.markdown setfiletype ghmarkdown
  au! BufRead,BufNewFile *.coffee setfiletype coffee
  au! BufRead,BufNewFile *.fdoc,*.fdoc.* setfiletype yaml
  au! BufRead,BufNewFile *.rdoc setfiletype rdoc
  au! BufRead,BufNewFile *.slim setfiletype slim
  au! BufRead,BufNewFile */.bundle/config setfiletype yaml
  au! BufRead,BufNewFile glide.lock setfiletype yaml
  au! BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
  au! BufRead,BufNewFile haproxy.cfg setfiletype haproxy
  au! BufRead,BufNewFile *.{mustache,handlebars,hbs,hogan,hulk,hjs}{,.erb} set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au! BufRead,BufNewFile /etc/systemd/system/*/*.conf setfiletype systemd
  au! BufRead,BufNewFile *.json,*.jsonp setfiletype json
  au! BufRead,BufNewFile /etc/php/php-fpm.conf,/etc/php/php-fpm.d/* setfiletype dosini
  au! BufRead,BufNewFile *.bats setfiletype sh
  au! BufRead,BufNewFile Gemfile.local setfiletype ruby
  au! BufRead,BufNewFile monitrc,monit/conf.d/*.conf setfiletype monitrc
  au! BufRead,BufNewFile *.scala setfiletype scala
  au! BufRead,BufNewFile *.vcl setfiletype vcl
  au! BufRead,BufNewFile rabbitmq.config setfiletype erlang
  au! BufRead,BufNewFile *.ex,*.exs setfiletype elixir
  au! BufRead,BufNewFile *.eex setfiletype elixir
  au! BufRead,BufNewFile *.tf,*.tfvars,*.hcl setfiletype terraform
  au! BufRead,BufNewFile *.tpl setfiletype terraform
  au! BufRead,BufNewFile .terraformrc setfiletype terraform
  au! BufRead,BufNewFile _*.tf.sandbox.*,_*.tf.staging.*,_*.tf.preview.*,_*.tf.production.* setfiletype terraform
  au! BufRead,BufNewFile *.tfstate setfiletype javascript
  au! BufRead,BufNewFile .env setfiletype conf
  au! BufRead,BufNewFile *.ts setfiletype typescript
  au! BufRead,BufNewFile PULLREQ_EDITMSG setfiletype gitcommit
  au! BufRead,BufNewFile *.blade.php setfiletype blade
  au! BufRead,BufNewFile go.mod,go.sum setfiletype gomod
augroup END
