" personal filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile *.ldf setfiletype tex
  autocmd BufRead,BufNewFile *.htc setfiletype javascript
  autocmd BufRead,BufNewFile */db/structure.sql setfiletype pgsql
  autocmd BufRead,BufNewFile *.sql setfiletype pgsql
  autocmd BufRead,BufNewFile *.pkg,*.cls,*.proc	setfiletype docbk
  autocmd BufRead,BufNewFile *.pp setfiletype puppet
  autocmd BufRead,BufNewFile *.hsc setfiletype haskell
  autocmd BufRead,BufNewFile *.sass setfiletype sass
  autocmd BufRead,BufNewFile Appraisals,capfile,Capfile,Guardfile,Vagrantfile,Berksfile,*.thor setfiletype ruby
  autocmd BufRead,BufNewFile */system/apache2/* setfiletype apache
  autocmd BufRead,BufNewFile */crontabs/* setfiletype crontab
  autocmd BufRead,BufNewFile *.md,*.markdown setfiletype ghmarkdown
  autocmd BufRead,BufNewFile *.coffee setfiletype coffee
  autocmd BufRead,BufNewFile *.fdoc,*.fdoc.* setfiletype yaml
  autocmd BufRead,BufNewFile *.rdoc setfiletype rdoc
  autocmd BufRead,BufNewFile *.slim setfiletype slim
  autocmd BufRead,BufNewFile */.bundle/config setfiletype yaml
  autocmd BufRead,BufNewFile glide.lock setfiletype yaml
  autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
  autocmd BufRead,BufNewFile haproxy.cfg setfiletype haproxy
  autocmd BufRead,BufNewFile *.{mustache,handlebars,hbs,hogan,hulk,hjs}{,.erb} set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  autocmd BufRead,BufNewFile /etc/systemd/system/*/*.conf setfiletype systemd
  autocmd BufRead,BufNewFile *.json,*.jsonp setfiletype json
  autocmd BufRead,BufNewFile /etc/php/php-fpm.conf,/etc/php/php-fpm.d/* setfiletype dosini
  autocmd BufRead,BufNewFile *.ini,.flake8 setfiletype dosini
  autocmd BufRead,BufNewFile *.bats setfiletype sh
  autocmd BufRead,BufNewFile Gemfile.local setfiletype ruby
  autocmd BufRead,BufNewFile monitrc,monit/conf.d/*.conf setfiletype monitrc
  autocmd BufRead,BufNewFile *.scala setfiletype scala
  autocmd BufRead,BufNewFile *.vcl setfiletype vcl
  autocmd BufRead,BufNewFile rabbitmq.config setfiletype erlang
  autocmd BufRead,BufNewFile *.ex,*.exs setfiletype elixir
  autocmd BufRead,BufNewFile *.eex setfiletype elixir
  autocmd BufRead,BufNewFile *.tf,*.tfvars,*.hcl setfiletype terraform
  autocmd BufRead,BufNewFile *.tpl,*.tftpl setfiletype terraform
  autocmd BufRead,BufNewFile .terraformrc setfiletype terraform
  autocmd BufRead,BufNewFile _*.tf.sandbox.*,_*.tf.staging.*,_*.tf.preview.*,_*.tf.production.* setfiletype terraform
  autocmd BufRead,BufNewFile *.tfstate setfiletype javascript
  autocmd BufRead,BufNewFile .env setfiletype conf
  autocmd BufRead,BufNewFile *.ts setfiletype typescript
  autocmd BufRead,BufNewFile PULLREQ_EDITMSG setfiletype gitcommit
  autocmd BufRead,BufNewFile *.blade.php setfiletype blade
  autocmd BufRead,BufNewFile go.mod,go.sum setfiletype gomod
  autocmd BufRead,BufNewFile Dockerfile.* setfiletype dockerfile
augroup END
