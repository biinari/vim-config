" PHP syntax: comments docblock {{{1
  " fold docBlocks
  syn cluster phpClValues add=phpDocBlock
  syn cluster phpClInClass add=phpDocBlock
  syn cluster phpClProtoValues add=phpDocBlock

  "syn region phpDocBlock start="/\*\*" end="\*/" contained extend
  "  \ contains=@Spell
  "  \ fold
" }}}

" PHP highlight: comments docblock {{{1
  hi phpDocBlock guifg=DarkGreen ctermfg=DarkGreen
" }}}

"set foldtext=DocBlockFoldText()
"function! DocBlockFoldText()
"  let line = getline(v:foldstart)
"  let sub = substitute(line, '/\*\*\n\|\*/\|{{{\d', '', 'g')
"  if sub == ''
"    let sub = substitute(getline(v:foldstart . j), '*','')
"  endif
"  return v:folddashes . sub
"endfunction

" vim: sw=2 sts=2 et fdm=marker fdc=1
