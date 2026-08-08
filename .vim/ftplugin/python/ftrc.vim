setlocal tabstop=4 shiftwidth=4 softtabstop=4

setlocal complete+=i,t

setlocal autoread

if exists(':Black') && executable('black')
  nnoremap <silent> <buffer> <F8> :Black<CR>
  augroup FormatPython
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> silent! execute ':Black'
  augroup END
endif
