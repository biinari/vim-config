function! Lint()
  ! php -n -l %
endfunction
command! -nargs=0 Lint call Lint()

function! Whitespace() range
  execute a:firstline . ',' . a:lastline . 's/\(\S\)\@<=\s\+$//ce'
  execute a:firstline . ',' . a:lastline . 's/\(\S\)\@<=\s*\t\s*/ /gce'
  execute a:firstline . ',' . a:lastline . 's/^\s\+class/class/ce'
  execute a:firstline . ',' . a:lastline . 's/^\(\s*class.*\S\){\s*$/\1 {/ce'
  execute a:firstline . ',' . a:lastline . 's/^ }/}/ce'
  execute a:firstline . ',' . a:lastline . 's/\<\(function\|while\|for\|foreach\|if\|do\|switch\)(/\1 (/gce'
  execute a:firstline . ',' . a:lastline . 's/}\(else\)\s*{/} \1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/\()\|else\){/\1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/,\c\(null\|false\|true\|\w*[:(]\)\?\a\@!\S\@=/, \1/gce'
  execute a:firstline . ',' . a:lastline . 's/\s\+\([;,]\)/\1/gce'
  execute a:firstline . ',' . a:lastline . 's/=<<</= <<</gce'
  " Space around operators = == === != !== += -= < <= > >= + - * / . .=
  " Ignores =\ => ={ // /* */ ++ -- </ /> >< <> \"< '< >\" >' >{ .. 0. .0
  let l:pattern = '\(' .
  \   '!=\{1,2}' .
  \   '\|' .                                                 '=\{2,3}' . '[\\>{]\@!' .
  \   '\|' . '\%(=\|\%(^\|[^$a-zA-Z0-9_]\)\w\+\|<?\)\@<!' .  '=' .       '[\\>{=]\@!' .
  \   '\|' . '[''">]\@<!' .                                  '<=\?' .    '[>\/?]\@!' .
  \   '\|' . '\%(<\/\?\w\+\%(\s*[a-zA-Z0-9_-]\+="[^"]*"\s*\|\s*[a-zA-Z0-9_-]\+=''[^'']*''\s*\)*\/\?\s*\|[<\/=-]\)\@<!' . '>=\?' .    '[''"<{]\@!' .
  \   '\|' .                                                 '[+-.]=' .
  \   '\|' . '+\@<!' .                                       '+' .       '+\@!' .
  \   '\|' . '\%(-\|\%(^\|[^$a-zA-Z0-9_]\)\a\w*\)\@<!' .     '-' .       '[->]\@!' .
  \   '\|' . '\/\@<!' .                                      '\*' .      '\/\@!' .
  \   '\|' . '[\/<]\@<!' .                                   '\/' .      '[\/>]\@!' .
  \   '\|' . '\%([0-9.]\|\%(^\|[^$a-zA-Z0-9_]\)\w\+\)\@<!' . '\.' .      '[0-9.]\@!' .
  \   '\)'
  execute a:firstline . ',' . a:lastline .
  \   's/\%([)"''\]}]\|\w\)\@<=' .
  \   l:pattern .
  \   '\([("''{\[\/]\|\d\|_\|\w\+[:(]\|null\|false\|true\|\$\)\@=' . '/ \1 /gce'
  execute a:firstline . ',' . a:lastline .
  \   's/\%([)"''\]}]\|\w\)\@<=' .
  \   l:pattern .
  \   '\(\w\+[:(]\|null\|false\|true\)\?\a\@!/ \1\2/gce'
  execute a:firstline . ',' . a:lastline .
  \   's/' .
  \   l:pattern .
  \   '\([("''{\[\/]\|\d\|_\|\w\+[:(]\|null\|false\|true\|\$\)\@=' . '/\1 /gce'
  " Multiline replace breaks future lastline references so set l:lastline
  let l:lastline = a:lastline
  let l:numlines = line('$')
  execute a:firstline . ',' . l:lastline . 's/}\s*\n\s*\(else\|catch\)/} \1/gce'
  let l:lastline -= l:numlines - line('$')
  let l:numlines = line('$')
  execute a:firstline . ',' . l:lastline . 's/else\s*\n\s*{/else {/gce'
  let l:lastline -= l:numlines - line('$')
  let l:numlines = line('$')
  execute a:firstline . ',' . l:lastline . 's/)\s*\n\s*{/) {/gce'
  let l:lastline -= l:numlines - line('$')
  let l:numlines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\(\s*\)\(if\s*(.\{-})\s*{\)\s*\(.*\)\s*}/\1\2\r\1    \3\r\1}/gce'
endfunction
command! -nargs=0 -range Whitespace <line1>,<line2>call Whitespace()

function! Multibyte() range
  execute a:firstline . ',' . a:lastline . 's/\(mb_\)\@<!\(split\|strcut\|strr\?i\?pos\|stri\?str\|strlen\|strtolower\|strtoupper\|substr\|substr_count\)/mb_\2/gce'
endfunction
command! -nargs=0 -range Multibyte <line1>,<line2>call Multibyte()

function! FixStyle() range
  execute a:firstline . ',' . a:lastline . 'retab'
  execute a:firstline . ',' . a:lastline . 's///e'
  execute a:firstline . ',' . a:lastline . 's/\s\+$//e'
  execute a:firstline . ',' . a:lastline . 's/\s\@<=--\s\@=/-/ce'
  execute a:firstline . ',' . a:lastline . 's/<?\(php\|=\)\@!/<?php/gce'
  execute a:firstline . ',' . a:lastline . 's/<?php\s\+echo \([^;]\{-}\);\?\s*?>/<?= \1 ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/<?php\s\+echo\s*(\([^;]\{-}\));\?\s*?>/<?= \1 ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/echo(\(.\{-}\))\s*;\s*$/echo \1;/gce'
  execute a:firstline . ',' . a:lastline . 's/\(include\|require\)\(_once\)\?\s*(\(.\{-}\));/\1\2 \3;/gce'
  execute a:firstline . ',' . a:lastline . 's/^\(<?\%(php\)\?\s*\)\?include/\1require/ce'
  execute a:firstline . ',' . a:lastline . 's/,\(\_s*)\)\@=//gce'
  execute a:firstline . ',' . a:lastline . 's/<>/!=/gce'
  execute a:firstline . ',' . a:lastline . 's/\<AND\>/\&\&/gce'
  execute a:firstline . ',' . a:lastline . 's/\<OR\>/||/gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<==>\S\@=/ => /gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<==>/ =>/gce'
  execute a:firstline . ',' . a:lastline . 's/=>\S\@=/=> /gce'
  execute a:firstline . ',' . a:lastline . 's/\([(\[!]\) /\1/gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<= \([\])]\)/\1/gce'
  execute a:firstline . ',' . a:lastline . 's/,\S\@=/, /gce'
  execute a:firstline . ',' . a:lastline . 's/\<\(if\|elseif\|for\|foreach\|while\)\@<=(/ (/gce'
  execute a:firstline . ',' . a:lastline . 's/){/) {/gce'
  execute a:firstline . ',' . a:lastline . 's/}else\s*{/} else {/gce'
  execute a:firstline . ',' . a:lastline . 's/else{/else {/gce'
  "execute a:firstline . ',' . a:lastline . 's/<?=\S\@=/<?= /gce'
  "execute a:firstline . ',' . a:lastline . 's/\S\@<=?>/ ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<=  \+/ /gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<=\([!=]==\?\)\S\@=/ \1 /gce'
  execute a:firstline . ',' . a:lastline . 's/\<\(False\|FALSE\|True\|TRUE\|Null\|NULL\)\>/\L\1\E/gce'

  " Multiline replace breaks future lastline references so set l:lastline
  let l:lastline = a:lastline
  let l:numlines = line('$')
  execute a:firstline . ',' . l:lastline . 's/echo\_s*(\_s*\(\_.\{-}\)\_s*)\_s*;/echo \1;/gce'
  let l:lastline -= l:numlines - line('$')
  let l:numlines = line('$')
endfunction
command! -nargs=0 -range FixStyle <line1>,<line2>call FixStyle()

set foldlevel=1

" vdebug paths
if exists('g:vdebug_options')
  let g:vdebug_options['path_maps'] = { '/home/vagrant/code/fatsoma': '/home/bill/code/fatsoma', '/mnt/local/master/fatsoma/_core': '/home/bill/code/fatsoma/fatsomacore', '/var/www/fatsomacore': '/home/bill/code/fatsoma/fatsomacore', '/usr/share/php/fatsoma': '/home/bill/code/fatsoma/fatsomacore/packages/php/fatsoma', '/usr/share/php/log4php': '/usr/share/pear/log4php' }
endif
