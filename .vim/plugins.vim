" Install vim-plug if not found.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif 

" Run PlugInstall if there are missing plugins.
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall
\| endif

call plug#begin('~/.vim/vim-plug')
  " === lightline === {{{
  Plug        'itchyny/lightline.vim'
  let g:lightline = {
    \ 'colorscheme': 'everforest',
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
  " === everforest === {{{
  Plug        'sainnhe/everforest'
  let g:everforest_transparent_background=1
  let g:everforest_disable_italic_comment=0
  let g:everforest_spell_foreground='colored'
  let g:everforest_ui_contrast='high'
  let g:everforest_background='soft'
  let g:everforest_enable_italic=1
  " }}}
  " === quick-scope === {{{
  Plug 'unblevable/quick-scope' 
  let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
  let g:qs_max_chars=120
  " }}}
  " === xptemplate === {{{
  Plug	      'drmingdrmer/xptemplate'
  let g:xptemplate_minimal_prefix=0
  " }}}
  " === gutentags === {{{
  Plug        'ludovicchabant/vim-gutentags'
  " }}}
  " === ctrlp === {{{
  Plug        'ctrlpvim/ctrlp.vim'
  " Use fd or rg for ctrlp.
  let g:ctrlp_use_caching=0
  if executable('fd')
    let g:ctrlp_user_command='fd --type f --color=never "" %s'
  elseif executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command='rg %s --files --color=never --glob ""'
  else
    let g:ctrlp_use_caching=1
    let g:ctrlp_clear_cache_on_exit=0
  endif
  " }}}
  " === sandwich === {{{
  Plug        'machakann/vim-sandwich'
  " }}}
  " === tagbar === {{{
  Plug	      'preservim/tagbar'
  " }}}
  " === qf === {{{
  Plug        'romainl/vim-qf'
  " }}}
  " === matchup === {{{
  Plug        'andymass/vim-matchup'
  " }}}
  " === abolish === {{{
    Plug        'tpope/vim-abolish'
  " }}}
  " === obsession === {{{
    Plug        'tpope/vim-obsession'
  " }}}
  " === unimpaired === {{{
    Plug        'tpope/vim-unimpaired'
  " }}}
  " === commentary === {{{
    Plug        'tpope/vim-commentary'
  " }}}
  " === repeat === {{{
    Plug        'tpope/vim-repeat'
  " }}}
  " === eunuch === {{{
    Plug        'tpope/vim-eunuch'
  " }}}
  " === asyncrun === {{{
  Plug	      'skywind3000/asyncrun.vim'
  " }}}
  " === asynccomplete === {{{
  Plug 'prabirshrestha/asyncomplete.vim'
  let g:asyncomplete_auto_completeopt = 0
  " }}}

  " === cxx === {{{
  " === vim-cpp-modern === {{{
  Plug        'bfrg/vim-cpp-modern'
  " }}}
  " }}}
  " === markdown === {{{
  " === vim-markdown === {{{
  Plug	      'bo1929/vim-markdown'
  " }}}
  " === tabular === {{{
  Plug        'godlygeek/tabular'
  " }}}
  " }}}
  " === la/tex === {{{ 
  if executable('latexmk')
    Plug        'lervag/vimtex'
    let g:vimtex_compiler_latexmk_engines = {
        \ '_': '-xelatex',
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
  endif
  " }}}
  " === jupytext === {{{
  if executable('jupytext')
    Plug        'goerz/jupytext.vim'
    let g:jupytext_fmt='py'
  endif
  " }}}
  " === khuno === {{{
  if executable('flake8')
    Plug        'alfredodeza/khuno.vim'
    let g:khuno_flake_cmd=$HOME . "/.local/pipx/venvs/flake8/bin/flake8"
    let g:khuno_builtins="_,apply"
    let g:khuno_max_line_length=99
  endif
  " }}}
  " }}}

  " === lsp === {{{
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " }}}
call plug#end()
