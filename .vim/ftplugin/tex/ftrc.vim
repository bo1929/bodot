setlocal spell
setlocal spelllang=en_us,tr

setlocal autoread

setlocal suffixesadd=.tex

setlocal conceallevel=2

setlocal complete+=k

set formatexpr=OneSentencePerLine()

function! IndentLatex()
  if executable('latexindent')
    let last_curpos = getcurpos()
    silent! execute ':%! latexindent -l'
    call setpos('.', last_curpos)
  endif
endfunction

augroup FormatLatex
  autocmd! BufWritePost *.tex execute ':call IndentLatex()'
augroup END

" Local settings to wrap lines.
silent call LocalWrap(0, repeat(">", &shiftwidth))
