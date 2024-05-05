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

if executable('pandoc')
  if exists(":AsyncRun")
    noremap <buffer> <C-A> :AsyncRun! pandoc %:p --template=eisvogel.tex -o %:r.pdf<CR>
    noremap <buffer> <C-B> :AsyncRun! pandoc %:p -t beamer --slide-level=2 -o %:r.pdf<CR>
  else
    noremap <buffer> <C-A> :!pandoc "%:p" --template=eisvogel.tex -o "%:r.pdf"<CR>
    noremap <buffer> <C-B> :!pandoc "%:p" -t beamer --slide-level=2 -o "%:r.pdf"<CR>
  endif
endif
