setlocal spell
setlocal spelllang=en_us,tr

setlocal autoread

setlocal conceallevel=2

setlocal foldtext=DotFoldText()

setlocal formatexpr=OneSentencePerLine()

" Local settings to wrap lines.
silent call LocalWrap(0, repeat(">", &shiftwidth))
