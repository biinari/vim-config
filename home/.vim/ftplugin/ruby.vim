" Tags
map <F8> :!RBENV_VERSION=system ripper-tags -R --exclude=vendor<CR>

function! ChefAttributesArraySyntax() range
  let l:i = 1
  while l:i < 6
    execute a:firstline . ',' . a:lastline . 's/\%(\%([\/"' . "'" . ']\)\@<!\<\%(node\.name\)\@!\%(node\|\%(force_\)\?default\|normal\|\%(force_\)\?override\|automatic\|set\%(_unless\)\?\)\>\%(\[[^\]]*\]\)*\%(\.\w\+\)*\)\@<=\.\(\%(\%(\%(force_\)\?default\|normal\|\%(force_\)\?override\|automatic\|set\%(_unless\)\?\|to_[ahis]\|tr\|g\?sub\|\%(chef_\)\?environment\|run_state\|recipes\|fetch\|inspect\|each\|map\|join\)\>\|\w\+[?]\)\@!\w\+\)/\[' . "'" . '\1' . "'" . '\]/gce'
    let l:i += 1
  endwhile
endfunction
command! -nargs=0 -range ChefAttributesArraySyntax <line1>,<line2>call ChefAttributesArraySyntax()
