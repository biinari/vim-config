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
  execute a:firstline . ',' . a:lastline . 's/\m\s\+$//ce'
  " execute a:firstline . ',' . a:lastline . 's/\m\<\(function\)(/\1 (/gce'
  execute a:firstline . ',' . a:lastline . 's/\m\<\(while\|for\|if\|do\|switch\|catch\)(/\1 (/gce'
  execute a:firstline . ',' . a:lastline . 's/\m}\(else\){/} \1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/\m\()\|else\|try\){/\1 {/gce'
  execute a:firstline . ',' . a:lastline . 's/\m}\(else\|catch\)/} \1/gce'
  execute a:firstline . ',' . a:lastline . 's/\m(\s\+/(/gce'
  execute a:firstline . ',' . a:lastline . 's/\m\S\@<=\s\+)/)/gce'
  execute a:firstline . ',' . a:lastline . 's/\m\S\@<=\s\+,/,/gce'
  execute a:firstline . ',' . a:lastline . 's/\m\\\@<!{[^{}/ ]\@=\([0-9,]*}\)\@!/{ /gce'
  execute a:firstline . ',' . a:lastline . 's/\m\%([^{}/[:space:]\\]\)\@<=\%({[0-9,]*\)\@<!}/ }/gce'
  execute a:firstline . ',' . a:lastline . 's/\m[a-zA-Z0-9_''"]\@<=:[a-zA-Z0-9_$({\[''"-]\@=/: /gce'
  execute a:firstline . ',' . a:lastline . 's/\m,\S\@=/, /gce'
  " Space around operators:
  " = == === != !== += -= < <= > >= << <<< >> >>> + - * / || &&
  " Ignores operators:
  " =\ // /* */ ++ -- </ /> >< <> \"< '< >\" >'
  let l:pattern = '\('.
  \                                '!=\+'.
  \ '\|'.'[!<]\@<!'.               '=\+'.     '\\\@!'.
  \ '\|'.'[''">]\@<!'.             '<[<=]*'.  '\%([>\/]\|[a-zA-Z0-9_.@-]\+\%( \?\/\)\?>\)\@!'.
  \ '\|'.'\%([<\/]\|<\/\?[a-zA-Z0-9_.@-]\+\)\@<!'.
  \                                '>[>=]*'.  '[''"<]\@!'.
  \ '\|'.                          '[+-/*]='.
  \ '\|'.'+\@<!'.                  '+'.       '+\@!'.
  \ '\|'.'\(-\|[<>=?:,]\s*\)\@<!'. '-'.       '-\@!'.
  \ '\|'.'\/\@<!'.                 '\*'.      '\/\@!'.
  \ '\|'.'[\/<]\@<!'.              '\/'.      '[\/>]\@!'.
  \ '\|'.                          '||'.
  \ '\|'.                          '&&'.
  \ '\)'
  execute a:firstline . ',' . a:lastline .
    \'s/\m\%([)"''\]}]\|\w\)\@<=' . l:pattern . '\([("''{\[\/$]\|\w\)\@=/ \1 /gce'
  execute a:firstline . ',' . a:lastline .
    \'s/\m\%([)"''\]}]\|\w\)\@<=\(' . l:pattern . '\|-\@<!--\@!\)/ \1/gce'
  execute a:firstline . ',' . a:lastline .
    \'s/\m' .  l:pattern . '\%([("''{\[\/$]\|\w\)\@=/\1 /gce'
  execute a:firstline . ',' . a:lastline .
    \'s/\m\%([<>=?:,]\)\@<=\(-\)/ \1/gce'

  " Execute these last as they can remove newlines
  let l:lastline = a:lastline
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m\(\<\%(function\s*\w\+\|\w\+\s*[:=]\s*function\|while\|for\|if\|do\|switch\|catch\)\s*(.*)\)\s\{-}\( \/\/.*\)\?\n\s*{/\1 {\2/gce'
  let l:lastline -= l:filelines - line('$')
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m}\s*\n\s*\(else\|catch\)/} \1/gce'
  let l:lastline -= l:filelines - line('$')
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m\(else\)\s*\n\s*{/\1 {/gce'
  let l:lastline -= l:filelines - line('$')
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m/\r/gce'
endfunction
command! -nargs=0 -complete=command -range Whitespace <line1>,<line2>call Whitespace()

function! Equivalent() range
  execute a:firstline . ',' . a:lastline . 's/\m[!=]\@<!\([!=]=\)=\@!/\1=/gce'
endfunction
command! -nargs=0 -complete=command -range Equivalent <line1>,<line2>call Equivalent()

function! Blocks() range
  " May change newlines
  let l:lastline = a:lastline
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m^\(\s*\)\(\%(if\|\%(}\s*\)\?else\s\+if\|for\|while\|do\|switch\|\%(}\s*\)\?catch\)\s*(.*)\)\s\+\([^{ ].*;$\)/\1\2 {\r\1  \3\r\1}/gce'
  let l:lastline += line('$') - l:filelines
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m^\(\s*\)\(\%(}\s*\)\?else\)\s\+\([^{ ].*;$\)/\1\2 {\r\1  \3\r\1}/gce'
  let l:lastline += line('$') - l:filelines
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m^\(\s*\)\(\%(if\|\%(}\s*\)\?else\s\+if\|for\|while\|do\|switch\|\%(}\s*\)\?catch\)\s*(.*)\)\s\{-}\( \/\/.*\)\?\n\(\%(\s\|\n\)*[^{ ]\S\_.\{-};\%(\s*\/\/.*\)\?$\)/\1\2 {\3\r\4\r\1}/gce'
  let l:lastline += line('$') - l:filelines
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m^\(\s*\)\(\%(}\s*\)\?else\)\s\{-}\( \/\/.*\)\?\n\(\%(\s\|\n\)*[^{ ]\S\_.\{-};\%(\s*\/\/.*\)\?$\)/\1\2 {\3\r\4\r\1}/gce'
endfunction
command! -nargs=0 -complete=command -range Blocks <line1>,<line2>call Blocks()

function! Retab4to2() range
  set ts=4 sw=4 noet
  execute a:firstline . ',' . a:lastline . 'retab!'
  set ts=2 sw=2 et
  execute a:firstline . ',' . a:lastline . 'retab!'
endfunction
command! -nargs=0 -complete=command -range Retab4to2 <line1>,<line2>call Retab4to2()
