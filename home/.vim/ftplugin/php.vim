function! Lint()
	! php -n -l %
endfunction
command! -nargs=0 -complete=command Lint call Lint()

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
	\	'!=\+' .
	\	'\|' .					'=\+' .		'[\\>{]\@!' .
	\	'\|' . '[''">]\@<!' .	'<=*' .		'[>\/]\@!' .
	\	'\|' . '[<\/=-]\@<!' .	'>=*' .		'[''"<{]\@!' .
	\	'\|' . 					'[+-]=' .
	\	'\|' . '+\@<!' .		'+' .		'+\@!' .
	\	'\|' . '-\@<!' .		'-' .		'[->]\@!' .
	\	'\|' . '\/\@<!' .		'\*' .		'\/\@!' .
	\	'\|' . '[\/<]\@<!' .	'\/' .		'[\/>]\@!' .
	\	'\|' . '[0-9.]\@<!' .	'\.' .		'[0-9.]\@!' .
	\	'\|' . '\.=' .
	\	'\)'
	execute a:firstline . ',' . a:lastline .
	\	's/\([)"''\]}]\|\w\)\@<=' . l:pattern . '\(\w\+[:(]\|null\|false\|true\)\?\a\@!/ \2\3/gce'
	execute a:firstline . ',' . a:lastline .
	\	's/' . l:pattern . '\([("''{\[\/]\|\d\|_\|\w\+[:(]\|null\|false\|true\|\$\)\@=' . '/\1 /gce'
	" Execute this last as it can remove newlines
	execute a:firstline . ',' . a:lastline . 's/}\s*\n\s*\(else\|catch\)/} \1/gce'
endfunction
command! -nargs=0 -complete=command -range Whitespace <line1>,<line2>call Whitespace()

function! Multibyte() range
	execute a:firstline . ',' . a:lastline . 's/\(mb_\)\@<!\(split\|strcut\|strr\?i\?pos\|stri\?str\|strlen\|strtolower\|strtoupper\|substr\|substr_count\)/mb_\2/gce'
endfunction
command! -nargs=0 -complete=command -range Multibyte <line1>,<line2>call Multibyte()

function! FixStyle() range
  execute a:firstline . ',' . a:lastline . 'retab'
  execute a:firstline . ',' . a:lastline . 's///e'
  execute a:firstline . ',' . a:lastline . 's/\s\+$//e'
  execute a:firstline . ',' . a:lastline . 's/\s\@<=--\s\@=/-/ce'
  execute a:firstline . ',' . a:lastline . 's/<?php\s\+echo \([^;]\{-}\);\?\s*?>/<?= \1 ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/<?php\s\+echo\s*(\([^;]\{-}\));\?\s*?>/<?= \1 ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/echo(\(.*\))\s*;\s*$/echo \1;$/e'
  execute a:firstline . ',' . a:lastline . 's/,\(\(\s\|\n\)*)\)\@=//gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<==>\S\@=/ => /gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<==>/ =>/gce'
  execute a:firstline . ',' . a:lastline . 's/=>\S\@=/=> /gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<= )/)/gce'
  execute a:firstline . ',' . a:lastline . 's/( /(/gce'
  execute a:firstline . ',' . a:lastline . 's/,\S\@=/, /gce'
  execute a:firstline . ',' . a:lastline . 's/\(if\|for\|foreach\|while\)\@<=(/ (/gce'
  execute a:firstline . ',' . a:lastline . 's/){/) {/gce'
  execute a:firstline . ',' . a:lastline . 's/}else\s*{/} else {/gce'
  execute a:firstline . ',' . a:lastline . 's/else{/else {/gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<=?>/ ?>/gce'
  execute a:firstline . ',' . a:lastline . 's/\S\@<=  / /gce'
  execute a:firstline . ',' . a:lastline . 's/\<\(False\|FALSE\|True\|TRUE\|Null\|NULL\)\>/\L\1\E/gce'
endfunction
command! -nargs=0 -complete=command -range FixStyle <line1>,<line2>call FixStyle()

set foldlevel=1

" vdebug paths
let g:vdebug_options["path_maps"] = { "/home/vagrant/code/fatsoma": "/home/bill/code/fatsoma", "/mnt/local/master/fatsoma/_core": "/home/bill/code/fatsoma/fatsomacore", "/var/www/fatsomacore": "/home/bill/code/fatsoma/fatsomacore", "/usr/share/php/fatsoma": "/home/bill/code/fatsoma/fatsomacore/packages/php/fatsoma", "/usr/share/php/log4php": "/usr/share/pear/log4php" }
