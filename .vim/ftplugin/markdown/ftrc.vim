setlocal spell
setlocal spelllang=en_us,tr

setlocal autoread

setlocal suffixesadd=.md

setlocal conceallevel=2

setlocal foldtext=DotFoldText()

set formatexpr=OneSentencePerLine()

" Local settings to wrap lines.
silent call LocalWrap(0, repeat(">", &shiftwidth))

if exists('*AlignTable')
  " Align tables.
  inoremap <silent> <buffer> <Bar> <Bar><Esc>:call AlignTable()<CR>a
endif
