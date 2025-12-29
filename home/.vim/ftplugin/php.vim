function! Multibyte() range
  execute a:firstline . ',' . a:lastline . 's/\(mb_\)\@<!\(split\|strcut\|strr\?i\?pos\|stri\?str\|strlen\|strtolower\|strtoupper\|substr\|substr_count\)/mb_\2/gce'
endfunction
command! -nargs=0 -range Multibyte <line1>,<line2>call Multibyte()

set foldlevel=1

" vdebug paths
if exists('g:vdebug_options')
  let g:vdebug_options['path_maps'] = {
    \ '/home/vagrant/code/fatsoma': '/home/bill/code/fatsoma',
    \ '/mnt/local/master/fatsoma/_core': '/home/bill/code/fatsoma/fatsomacore',
    \ '/var/www/fatsomacore': '/home/bill/code/fatsoma/fatsomacore',
    \ '/usr/share/php/fatsoma': '/home/bill/code/fatsoma/fatsomacore/packages/php/fatsoma',
    \ '/usr/share/php/log4php': '/usr/share/pear/log4php'
  \ }
endif
