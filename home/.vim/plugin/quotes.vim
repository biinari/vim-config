if exists("loaded_quotes")
	finish
endif
let loaded_quotes = 1

function! SingleQuote() range
	execute a:firstline . ',' . a:lastline . 's/"/''/g'
	execute a:firstline . ',' . a:lastline . 's/\\\''/"/g'
endfunction
command! -nargs=0 -complete=command SingleQuote call SingleQuote()
