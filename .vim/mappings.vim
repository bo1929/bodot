" Leader mapping.
nnoremap <Space> <Nop>
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" Visual select all text in buffer.
noremap <leader>va ggVG

" Better yank, use + register.
noremap <leader>y "+y
" noremap <leader>y "*y
" Better paste, use + register.
noremap <leader>p "+p
" noremap <leader>p "*p
" Alternative delete, use _ register.
noremap <leader>d "_d
" Alternative change, use _ register.
noremap <leader>c "_c

" Use <leader>bl to toggle to the last buffer.
nnoremap <leader>bl <C-^>
" Use <leader>bn to toggle to the next buffer.
noremap <silent> <leader>bn :bn<CR>
" Use <leader>bp to toggle to the previous buffer.
noremap <silent> <leader>bp :bp<CR>
" Use <leader>bd to delete the current buffer.
noremap <silent> <leader>bd :bd<CR>

" Run last macro with Q.
nnoremap Q @@

" Keep pressing ~ until you get the case you want.
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Toggle background, light or dark.
noremap <silent> <leader>BG :call ToggleBG()<CR>

" Disable arrow-keys.
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Clear the search register (removes highlighting).
nnoremap <silent> \ :let @/=""<CR>

" Do a search for the text in the " register.
nnoremap <leader>"/ /<C-R>"<CR>
nnoremap <leader>"s :%s/<C-R>"/<text>/g

function! MapPluginKeyBindings()
  if exists(":TagbarToggle")
    nnoremap <silent> <leader>T :TagbarToggle<CR>
  endif
  if exists(":LspDocumentDiagnostics")
    nnoremap <silent> <leader>L :call ToggleDiagnosticsLSP()<CR>
  endif
  " Confirm popup selection with <CR> (asyncomplete is autoloaded on first use).
  inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
endfunction

augroup PluginMappings
  autocmd!
  autocmd VimEnter * call MapPluginKeyBindings()
augroup END

" Toggle the vertical netrw explorer from any buffer.
nnoremap <silent> <leader>- :call ToggleNetrwExplorer()<CR>
" Jump to the netrw explorer window from any buffer.
nnoremap <silent> <leader>+ :call SwitchNetrwWindow()<CR>
