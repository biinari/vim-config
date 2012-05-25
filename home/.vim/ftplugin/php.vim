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
	execute a:firstline . ',' . a:lastline . 's/}\(else\){/} \1 {/gce'
	execute a:firstline . ',' . a:lastline . 's/\()\|else\){/\1 {/gce'
	execute a:firstline . ',' . a:lastline . 's/}\(else\)/} \1/gce'
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

set foldlevel=1
