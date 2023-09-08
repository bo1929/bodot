setlocal tabstop=4 shiftwidth=4 softtabstop=4

setlocal complete+=i,t

setlocal autoread

if exists(':Black') && executable('black')
  nnoremap <silent> <buffer> <F8>: Black<CR>
  augroup FormatPython
    autocmd BufWritePre *.py silent! execute ':Black'
  augroup END
endif

if exists(':Khuno') && executable('flake8')
  nmap <silent> <buffer> <F7> <Esc>: Khuno show<CR>
endif
