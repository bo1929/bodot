" Install vim-plug if not found.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif 

" Run PlugInstall if there are missing plugins.
augroup PlugAutoInstall
  autocmd!
  autocmd VimEnter * if exists('g:plugs') && len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall
  \| endif
augroup END

call plug#begin('~/.vim/vim-plug')
  " === basics === {{{
  Plug        'machakann/vim-sandwich'
  Plug        'romainl/vim-qf'
  Plug        'tpope/vim-eunuch'
  Plug        'tpope/vim-repeat'
  Plug        'tpope/vim-commentary'
  Plug        'tpope/vim-unimpaired'
  Plug        'tpope/vim-obsession'
  Plug        'tpope/vim-fugitive'
  Plug        'tpope/vim-abolish'
  " }}}

  " === colorscheme === {{{
  " Fallback colorscheme; the terminal's theme state wins when present
  " (see SyncColorschemeWithTerminal in misc.vim).
  let g:active_colorscheme='gruvbox'
  Plug        'gruvbox-community/gruvbox'
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_contrast_light='hard'
  let g:gruvbox_italic=1
  " }}}

  " === everforest (alternative colorscheme) === {{{
  " Select it via g:active_colorscheme in the colorscheme section above.
  Plug        'sainnhe/everforest'
  let g:everforest_transparent_background=1
  let g:everforest_disable_italic_comment=0
  let g:everforest_spell_foreground='colored'
  let g:everforest_ui_contrast='high'
  let g:everforest_background='soft'
  let g:everforest_enable_italic=1
  " }}}

  " === lightline === {{{
  Plug        'itchyny/lightline.vim'
  let g:lightline={
    \ 'colorscheme': g:active_colorscheme,
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ],
    \            [ 'format-options', 'obsession-status', 'percent' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'tabs' ] ],
    \   'right': []
    \ },
    \ 'tab': {
    \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
    \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
    \ },
    \ 'component': {
    \   'format-options': '[%{&fo}]',
    \ },
    \ 'component_function': {
    \   'obsession-status': 'ObsessionStatus',
    \ },
    \ }
  " }}}

  " === quick-scope === {{{
  Plug 'unblevable/quick-scope' 
  let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
  let g:qs_max_chars=120
  " }}}

  " === gutentags === {{{
  let s:ctags_path='/usr/bin/ctags'
  for s:ctags_path in [
        \ '/opt/homebrew/opt/ctags/bin/ctags',
        \ '/usr/bin/ctags',
        \ 'ctags',
        \ ]
    if executable(s:ctags_path)
      Plug        'ludovicchabant/vim-gutentags'
      let g:gutentags_ctags_executable=s:ctags_path
      " Keep tag files out of project roots.
      call mkdir($HOME . '/.cache/vim/tags', 'p')
      let g:gutentags_cache_dir=$HOME . '/.cache/vim/tags'
      break
    endif
  endfor
  " }}}

  " === matchup === {{{
  Plug        'andymass/vim-matchup'
  let g:matchup_matchparen_offscreen = {'method': 'status_manual'}
  " }}}

  " === cpp === {{{
  Plug        'bfrg/vim-cpp-modern'
  " }}}

  " === markdown === {{{
  Plug    'bo1929/vim-markdown'
  " }}}

  " === la/tex === {{{ 
  if executable('latexmk')
    Plug        'lervag/vimtex'
    let g:vimtex_compiler_latexmk_engines={'_': '-xelatex'}
    let g:vimtex_compiler_latexmk={
        \ 'aux_dir' : '/tmp',
        \ 'out_dir' : '/tmp',
      \}
    let g:tex_fast=""
    let g:vimtex_fold_manual=0
    let g:vimtex_fold_enabled=0
    let g:vimtex_matchparen_enabled=0
    let g:vimtex_include_search_enabled=0
    let g:vimtex_quickfix_autoclose_after_keystrokes=1
    if executable('zathura')
      let g:vimtex_view_method='zathura'
    endif
  endif
  " }}}

  " === python === {{{
  " === black === {{{
  if executable('black')
    Plug        'psf/black', {'for': 'python'}
    let g:black_virtualenv=$HOME . "/.local/pipx/venvs/black"
    let g:black_skip_magic_trailing_comma=1
    let g:black_linelength = 100
  endif
  " }}}
  " === jupytext === {{{
  if executable('jupytext')
    Plug        'goerz/jupytext.vim'
    let g:jupytext_fmt='py'
  endif
  " }}}
  " }}}

  " === asyncrun === {{{
  Plug    'skywind3000/asyncrun.vim'
  " }}}

  " === asyncomplete === {{{
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  let g:asyncomplete_auto_completeopt=0
  Plug 'hiterm/asyncomplete-look'
  au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'look',
    \ 'whitelist': ['markdown'],
    \ 'completor': function('asyncomplete#sources#look#completor'),
    \ })
  " }}}

  " === lsp & autocomplete === {{{
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  " let g:lsp_diagnostics_highlights_enabled = 0
  " let g:lsp_experimental_workspace_folders = 1
  " let g:lsp_diagnostics_enabled = 0  
  let g:lsp_document_highlight_enabled=0
  let g:lsp_semantic_enabled=0
  let g:lsp_diagnostics_echo_cursor=0
  " let g:lsp_diagnostics_float_cursor=1
  " LSP highlight overrides live in misc.vim (ColorScheme autocmd).
  let g:lsp_diagnostics_signs_error={'text': '✗'}
  let g:lsp_diagnostics_signs_warning={'text': '¿'}
  let g:lsp_diagnostics_virtual_text_enabled=0
  " set foldmethod=expr
  "   \ foldexpr=lsp#ui#vim#folding#foldexpr()
  "   \ foldtext=lsp#ui#vim#folding#foldtext()
  " let g:lsp_fold_enabled=1
  " Plug 'Exafunction/windsurf.vim'
  " }}}

""" Inactive:
  " === auto-popmenu === {{{
  " Disabled: redundant with asyncomplete — both auto-drive the popup menu
  " and fight over <CR>/completeopt. asyncomplete (LSP + look) wins.
  " Plug        'skywind3000/vim-auto-popmenu'
  " let g:apc_enable_ft={"*":1}
  " let g:apc_enable_tab=0
  " let g:apc_cr_confirm=1
  " }}}

  " === tagbar === {{{
  " if executable('ctags')
  "   Plug    'preservim/tagbar'
  "   " let g:tagbar_position='leftabove vertical'
  " endif
  " }}}

  " === ctrlp === {{{
  " Plug        'ctrlpvim/ctrlp.vim'
  " " Use fd or rg for ctrlp.
  " let g:ctrlp_use_caching=0
  " if executable('fd')
  "   let g:ctrlp_user_command='fd --type f --color=never "" %s'
  " elseif executable('rg')
  "   set grepprg=rg\ --color=never
  "   let g:ctrlp_user_command='rg %s --files --color=never --glob ""'
  " else
  "   let g:ctrlp_use_caching=1
  "   let g:ctrlp_clear_cache_on_exit=0
  " endif
  " }}}

call plug#end()
