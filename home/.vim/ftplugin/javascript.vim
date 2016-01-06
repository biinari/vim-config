set makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ '/etc/jsl.conf'\ -process\ %
set errorformat=%f(%l):\ %m

" Run JavaScript Lint from www.javascriptlint.com
function! JSLint()
  redir => message
  silent ! jsl -nologo -nofilelisting -nosummary -nocontext -conf /etc/jsl.conf -output-format '__LINE__: __ERROR__' -process %
  redir END
  split new
  silent put=message
  silent %s///
  1,2d
  2
  set nomodified
endfunction
command! -nargs=0 -complete=command JSLint call JSLint()

function! Whitespace() range
  execute a:firstline . ',' . a:lastline . 's/\<\(function\|while\|for\|if\|do\|switch\|catch\)(/\1 (/gce'
  execute a:firstline . ',' . a:lastline . 's/}\(else\){/} \1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/\()\|else\|try\){/\1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/}\(else\|catch\)/} \1/gce'
  execute a:firstline . ',' . a:lastline . 's/,\S\@=/, /gce'
  " Space around operators = == === != !== += -= < <= > >= + - * / || &&
  " Ignores =\ // /* */ ++ -- </ /> >< <> \"< '< >\" >'
  let l:pattern = '\(' .
  \	'!=\+' .
  \	'\|' .					'=\+' .		'\\\@!' .
  \	'\|' . '[''">]\@<!' .	'<=*' .		'[>\/]\@!' .
  \	'\|' . '[<\/]\@<!' .	'>=*' .		'[''"<]\@!' .
  \	'\|' .					'[+-]=' .
  \	'\|' . '+\@<!' .		'+' .		'+\@!' .
  \	'\|' . '-\@<!' .		'-' .		'-\@!' .
  \	'\|' . '\/\@<!' .		'\*' .		'\/\@!' .
  \	'\|' . '[\/<]\@<!' .	'\/' .		'[\/>]\@!' .
  \	'\|' .					'||' .
  \	'\|' .					'&&' .
  \	'\)'
  execute a:firstline . ',' . a:lastline .
  \	's/\([)"''\]}]\|\w\)\@<=' . l:pattern . '/ \2/gce'
  execute a:firstline . ',' . a:lastline .
  \	's/' .  l:pattern . '\([("''{\[\/]\|\w\)\@=/\1 /gce'
  " Execute this last as it can remove newlines
  execute a:firstline . ',' . a:lastline . 's/}\s*\n\s*\(else\|catch\)/} \1/gce'
endfunction
command! -nargs=0 -complete=command -range Whitespace <line1>,<line2>call Whitespace()

function! Equivalent() range
  execute a:firstline . ',' . a:lastline . 's/[!=]\@<!\([!=]=\)=\@!/\1=/gce'
endfunction
command! -nargs=0 -complete=command -range Equivalent <line1>,<line2>call Equivalent()
