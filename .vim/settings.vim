filetype plugin indent on
set nocompatible
set encoding=utf-8

" === General Settings === {{{
" No beep beep.
set belloff=all
" Buffer becomes hidden when it is abandoned.
set hidden
" Always show tab page labels.
set showtabline=2
" Last window will always have a status line.
set laststatus=2
" Always show cursor position
set ruler
" Display command line’s tab complete options as a menu.
set wildmenu
" set wildoptions=pum
" Make backspace behave like usual.
set backspace=indent,eol,start
" Timeout for key sequences, mappings.
set timeout ttimeout
set timeoutlen=1000 ttimeoutlen=100
" Show current line number.
set number
" Show relative line numbers.
set relativenumber
" Immediately perceive Escape in insert mode.
set noesckeys
" Indicates a fast terminal connection, smoother.
set ttyfast
" Display incomplete commands.
set showcmd
" Use the new regular expression engine.
set re=0
" A swap file will be written after this many milliseconds.
set updatetime=500
" }}}

" === Directories === {{{
function MakeDirectory(path_directory)
  if !isdirectory(a:path_directory)
    call mkdir(a:path_directory, "p")
  endif
endfunction
" Set swap directory.
let swap_directory=$HOME . '/.cache/vim/swap'
call MakeDirectory(swap_directory)
if isdirectory(swap_directory)
  let &dir=swap_directory
endif
" Set backup location and backup.
set backup
let backup_directory=$HOME . '/.cache/vim/backup'
call MakeDirectory(backup_directory)
if isdirectory(backup_directory)
  let &backupdir=backup_directory
endif
" Set undodir and undofile.
set undofile
set undoreload=50000
let undo_directory=$HOME . '/.cache/vim/undo'
call MakeDirectory(undo_directory)
if isdirectory(undo_directory)
  let &undodir=undo_directory
endif
" }}}

" === Netrw === {{{
" Set netrw home directory.
let netrw_directory=$HOME . '/.cache/vim/netrw'
call MakeDirectory(netrw_directory)
if isdirectory(netrw_directory)
  let g:netrw_home=netrw_directory
endif
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv = 1
let g:netrw_preview=1
let g:netrw_browse_split=4
let g:netrw_winsize=50
let g:netrw_localrmdir='rm -r'
" }}}

" === Default Indentation === {{{
" New lines inherit indentation.
set autoindent
" Convert tabs to spaces.
set expandtab
" Round the indent to a multiple of shiftwidth.
set shiftround
" Show existing tab with 2 spaces width (default).
set tabstop=2
" When indenting with '>', use 2 spaces width (default).
set shiftwidth=2
" Number of spaces that a <Tab> counts.
set softtabstop=2
" }}}

" === Search Settings === {{{
" Highlight all its matches.
set hlsearch
" Do incremental searching.
set incsearch
" Case-insensitive search.
set wildignorecase
" Make :grep use rg, if available.
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" === Cursor === {{{
" Change cursor while chaning mode.
let &t_SI="\e[6 q"
" Change cursor while chaning mode.
let &t_EI="\e[2 q"
" Stop cursor blanking.
set guicursor+=a:blinkon0
" Do not show cursor-line.
set nocursorline
" Do not show cursor-column.
set nocursorcolumn
" }}}

" === Wrapping === {{{
" Do not use wrapping and related settings.
set nowrap
set nojoinspaces
set textwidth=0 
set wrapmargin=0
set sidescroll=1
set listchars+=precedes:<,extends:>
" }}}

" === Insertion Completion === {{{
set complete=.,w,b,u,k
set completeopt=menuone,noinsert,noselect,preview
set omnifunc=syntaxcomplete#Complete
" Don't give ins-completion-menu messages.
set shortmess+=c
set pumheight=10
" }}}

" === Screen Splitting === {{{
" Put new window to the below of current one.
set splitbelow
" Put new window to the right of current one.
set splitright
" }}}

" === Folding === {{{
" Use markers to define folds.
set foldmethod=marker
" }}}

" === Visual Related === {{{
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  let &t_ut=''
  set termguicolors
endif

try
  colorscheme everforest
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme darkblue
endtry

if has('gui_running')
  set background=light
else
  set background=dark
  set t_Co=256
endif

" Set the vertical split character to a space.
set fillchars+=vert:\ 

" Don't redraw for macros, auto-commands etc.
set lazyredraw

" Enable syntax highlighting.
syntax enable
syntax sync minlines=512
syntax sync maxlines=1024
" }}}
