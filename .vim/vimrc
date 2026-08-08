" Use Vim settings, not Vi.
" Must come first: everything sourced below relies on nocompatible features.
if &compatible
  set nocompatible
endif

" Source the modular config files, in order.
for s:config_file in ['plugins.vim', 'misc.vim', 'mappings.vim', 'settings.vim']
  let s:config_path=$HOME . '/.vim/' . s:config_file
  if filereadable(s:config_path)
    execute 'source ' . fnameescape(s:config_path)
  endif
endfor
unlet s:config_file s:config_path
