function! Equivalent() range
  execute a:firstline . ',' . a:lastline . 's/\m[!=]\@<!\([!=]=\)=\@!/\1=/gce'
endfunction
command! -nargs=0 -range Equivalent <line1>,<line2>call Equivalent()

function! EmberCleanup() range
  let l:lastline = a:lastline
  let l:filelines = line('$')

  " Convert from prototype extensions
  " String camelize(), fmt()
  execute a:firstline . ',' . l:lastline . 's/\m\(\\\@<!''[^'']\{-}\\\@<!''\)\.(fmt\|\%(de\)\?camelize\|dasherize\|underscore\|classify\|capitalize\|htmlSafe\|loc\|w\)()/Ember\.string\.\2(\1)/ce'
  " Function on(), observes(), property()
  execute a:firstline . ',' . l:lastline . 's/\m\(function\s*(.*)\s*{\s*\n\_.\{-}\n\s*}\)\(\.on([^)]*\))/Ember\2, \1)/ce'
  execute a:firstline . ',' . l:lastline . 's/\m\(function\s*(.*)\s*{\s*\n\_.\{-}\n\s*}\)\.observes\(([^)]*\))/Ember\.observer\2, \1)/ce'
  execute a:firstline . ',' . l:lastline . 's/\m\(function\s*(.*)\s*{\s*\n\_.\{-}\n\s*}\)\.observesImmediately\(([^)]*\))/Ember\.immediateObserver\2, \1)/ce'
  execute a:firstline . ',' . l:lastline . 's/\m\(function\s*(.*)\s*{\s*\n\_.\{-}\n\s*}\)\.observesBefore\(([^)]*\))/Ember\.beforeObserver\2, \1)/ce'
  execute a:firstline . ',' . l:lastline . 's/\m\(function\s*(.*)\s*{\s*\n\_.\{-}\n\s*}\)\.property\(([^)]*\))/Ember\.computed\2, \1)/ce'

  " Execute these last as they can remove lines

  " Remove blank lines from beginning / end of blocks
  execute a:firstline . ',' . a:lastline . 's/\m\({\s*\n\)\s*\n/\1/ce'
  let l:lastline += line('$') - l:filelines
  let l:filelines = line('$')
  execute a:firstline . ',' . l:lastline . 's/\m^\s*\n\(\s*}\)/\1/ce'
endfunction
command! -nargs=0 -range EmberCleanup <line1>,<line2>call EmberCleanup()
