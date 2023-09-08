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
" Use <leader>bl to toggle to the previous buffer.
noremap <silent> <leader>bp :bp<CR>
" Use <leader>bd to delete the current buffer.
noremap <silent> <leader>bd :bd<CR>

" Run last macro with Q.
nnoremap Q @@

" Keep pressing ~ until you get the case you want.
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Toggle background, light or dark.
noremap <silent> <F3> :call ToggleBG()<CR>

" Toggle vertical explorer.
noremap <silent> <leader>- :call ToggleVExplorer()<CR>

" Disable arrow-keys.
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Clear \ register.
" As a result remove highlighting.
nnoremap <silent> \ :let @/=""<CR>

" Do a search for the text in the " register.
nnoremap <leader>"/ /<C-R>"<CR>
nnoremap <leader>"s :%s/<C-R>"/<text>/g

function! MapPluginKeyBindings()
  if exists(":TagbarToggle")
    nnoremap <silent> <F5> :TagbarToggle<CR>
  endif
  if exists(":LspDocumentDiagnostics")
    nnoremap <silent> <F3> :call ToggleDiagnosticsLSP()<CR>
  endif
  if exists("*asyncomplete#close_popup")
    inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
  endif

endfunction

augroup PluginMappings
  autocmd VimEnter * call MapPluginKeyBindings()
augroup END

function! MapNetrwKeyBindings()
  " Toggle vertical explorer.
  noremap <buffer> <silent> <leader>- :call ToggleVExplorer()<CR>
  nmap <buffer> <silent> <Tab> <CR>:call SwitchNetrwWindow()<CR>
endfunction

augroup NetrwMappings
  autocmd Filetype netrw call MapNetrwKeyBindings()
augroup END
