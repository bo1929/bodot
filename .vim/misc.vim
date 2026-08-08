" Toggle netrw explorer window.
function! ToggleNetrwExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num=bufwinnr(t:expl_buf_num)
    unlet t:expl_buf_num
    if expl_win_num != -1
      exec expl_win_num . "wincmd w"
      try
        close
      catch /^Vim\%((\a\+)\)\=:E444/
        b#
      endtry
      return
    endif
    " Explorer buffer was hidden, fall through and reopen it.
  endif
  25Lexplore
  let t:expl_buf_num=bufnr("%")
endfunction

" Swicth to netrw explorer window.
function! SwitchNetrwWindow()
  if exists("t:expl_buf_num")
    let expl_win_num=bufwinnr(t:expl_buf_num)
    if expl_win_num!=-1
      exec expl_win_num . "wincmd w"
    endif
  endif
endfunction

" Twiddle the case of text under the cursor.
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result=tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result=substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result=toupper(a:str)
  endif
  return result
endfunction

" Alignment for tables using Tabularize.
function! AlignTable()
  let p='^\s*|\s.*\s|\s*$'
  if exists(":Tabularize") && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column=strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position=strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function! HiNoneBG()
  " Transparent editor background.
  hi Normal guibg=NONE ctermbg=NONE
  hi Folded guibg=NONE ctermbg=NONE
  " Gutters, separators and filler areas too.
  hi SignColumn guibg=NONE ctermbg=NONE
  hi FoldColumn guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi CursorLineNr guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
  hi VertSplit guibg=NONE ctermbg=NONE
  hi WinSeparator guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  " hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
  " hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
  " hi SpecialKey ctermbg=NONE
endfunction

" Severity/diagnostic styling: colored fg + undercurl, no solid boxes.
" Links to the active scheme's own groups, so colors follow the scheme.
function! SetPlugHi()
  " matchparen/vim-matchup pairs: bold underline, no box.
  highlight MatchParen cterm=bold,underline gui=bold,underline ctermbg=NONE guibg=NONE
  " Symbol references: underline, no block.
  highlight lspReference cterm=underline gui=underline ctermbg=NONE guibg=NONE
  if get(g:, 'colors_name', '') ==# 'gruvbox'
    highlight! link LspErrorHighlight GruvboxRedUnderline
    highlight! link LspWarningHighlight GruvboxYellowUnderline
    highlight! link LspInformationHighlight GruvboxBlueUnderline
    highlight! link LspHintHighlight GruvboxAquaUnderline
    highlight! link LspErrorText GruvboxRedSign
    highlight! link LspWarningText GruvboxYellowSign
    highlight! link LspInformationText GruvboxBlueSign
    highlight! link LspHintText GruvboxAquaSign
    highlight! link LspErrorVirtualText GruvboxRed
    highlight! link LspWarningVirtualText GruvboxYellow
    highlight! link LspInformationVirtualText GruvboxBlue
    highlight! link LspHintVirtualText GruvboxAqua
    highlight! link ErrorMsg GruvboxRed
    " Sign glyph groups keep their color but drop the opaque bg strip.
    highlight GruvboxRedSign guibg=NONE ctermbg=NONE
    highlight GruvboxGreenSign guibg=NONE ctermbg=NONE
    highlight GruvboxYellowSign guibg=NONE ctermbg=NONE
    highlight GruvboxBlueSign guibg=NONE ctermbg=NONE
    highlight GruvboxPurpleSign guibg=NONE ctermbg=NONE
    highlight GruvboxAquaSign guibg=NONE ctermbg=NONE
    highlight GruvboxOrangeSign guibg=NONE ctermbg=NONE
  elseif get(g:, 'colors_name', '') ==# 'everforest'
    highlight! link LspErrorHighlight DiagnosticUnderlineError
    highlight! link LspWarningHighlight DiagnosticUnderlineWarn
    highlight! link LspInformationHighlight DiagnosticUnderlineInfo
    highlight! link LspHintHighlight DiagnosticUnderlineHint
    highlight! link LspErrorText RedSign
    highlight! link LspWarningText YellowSign
    highlight! link LspInformationText BlueSign
    highlight! link LspHintText AquaSign
    highlight! link LspErrorVirtualText Red
    highlight! link LspWarningVirtualText Yellow
    highlight! link LspInformationVirtualText Blue
    highlight! link LspHintVirtualText Aqua
    highlight! link ErrorMsg Red
  endif
endfunction

function! HiClear()
  hi clear CursorLine
  " hi clear SignColumn
  " hi clear LineNr
endfunction

function! RefreshLightlinePalette()
  if !exists('g:lightline') || !exists('g:colors_name')
    return
  endif
  silent! execute 'runtime! autoload/lightline/colorscheme/' . g:colors_name . '.vim'
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! SwitchTerminalTheme()
  let theme_map={
        \ 'gruvbox': {'dark': 'gruvbox_dark', 'light': 'gruvbox_light'},
        \ 'everforest': {'dark': 'everforest_dark_soft', 'light': 'everforest_light_soft'},
        \ }
  let script=$HOME . '/.config/theme/switch_colorscheme.sh'
  if !has_key(theme_map, get(g:, 'colors_name', '')) || !executable(script)
    return
  endif
  let theme=theme_map[g:colors_name][&background]
  if has('job')
    call job_start([script, theme])
  else
    call system(script . ' ' . theme . ' &')
  endif
endfunction

function! SyncColorschemeWithTerminal()
  let name=$LC_THEME
  if name ==# ''
    let conf=$HOME . '/.config/theme/colorschemes.toml'
    if !filereadable(conf)
      return 0
    endif
    " Basename of the imported theme file, e.g. 'gruvbox_dark'.
    let name=substitute(matchstr(join(readfile(conf)), '[^"/]\+\.toml'), '\.toml$', '', '')
  endif
  if name !~# '^\(gruvbox\|everforest\)_'
    " Foreign theme: keep the default scheme.
    " Follow the dark/light suffix (unknown suffix assumed dark).
    let &background=(name =~# '_light' ? 'light' : 'dark')
    return 1
  endif
  let g:active_colorscheme=split(name, '_')[0]
  let &background=(name =~# 'light' ? 'light' : 'dark')
  return 1
endfunction

function! ToggleBG()
  let &background=( &background == "dark"? "light" : "dark" )
  if exists("g:colors_name")
    exe "colorscheme " . g:colors_name
  endif
  call HiClear()
  call HiNoneBG()
  call RefreshLightlinePalette()
  call SwitchTerminalTheme()
  redraw!
endfunction

function! DotFoldText()
  let nblines=v:foldend - v:foldstart + 1
  let w=winwidth(0) - &foldcolumn - (&number ? 3 : 0)
  let expansionString=repeat(".", w - strwidth(nblines.'"') - 1)
  let txt=nblines . " " . expansionString
  return txt
endfunction

fun! TrimWhitespace()
  let l:save=winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

function! OneSentencePerLine()
  if mode() =~# '^[iR]'
    return
  endif
  let indentation_level=indent('.') / &shiftwidth
  let indentation_command=repeat('>', indentation_level)
  let start=v:lnum
  let end=start + v:count - 1
  execute start.','.end.'join'
  s/\(^\s*\d\+\)\@<!\(\<al\)\@<![.!?] \zs\s*\ze\S/\r/g
  call TrimWhitespace()
  exec end+1.','.line(".").indentation_command
endfunction

function! LocalWrap(tw=0, sb='>', ba=' ^I!@*-+;:,./?')
  setlocal wrap
  setlocal nolist
  setlocal linebreak
  setlocal breakindent
  " Set tw=0 to soft wrap.
  let &l:textwidth=a:tw
  let &l:showbreak=a:sb
  let &l:breakat=a:ba
endfunction

function! LocalNoWrap()
  setlocal nowrap
  setlocal nolinebreak
  setlocal nojoinspaces
  setlocal sidescroll=1
  setlocal textwidth=0 
  setlocal wrapmargin=0
  setlocal listchars+=precedes:<,extends:>
endfunction

" Append timestamps.
if !exists(":AppendDate")
  command! AppendDate :normal a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
endif

" New commands for async 'grep' and 'make'.
if exists(":AsyncRun")
  if !exists(":AsyncMake") 
    command! -bang -nargs=* -complete=file -bar AsyncMake  AsyncRun<bang> -program=make -auto=make @ <args>
  endif
  if !exists(":AsyncGrep") 
    command! -bang -nargs=* -complete=file -bar AsyncGrep  AsyncRun<bang> -program=grep -auto=grep @ <args>
  endif
endif

augroup SetupAutoCompletion
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

function! ToggleDiagnosticsLSP()
  if exists('*lsp#disable_diagnostics_for_buffer')
    if get(b:, 'lsp_diagnostics_enabled', 0)
        call lsp#disable_diagnostics_for_buffer()
        let b:lsp_diagnostics_enabled=0
        " echo "LSP diagnostics is disabled."
    else
        call lsp#enable_diagnostics_for_buffer()
        let b:lsp_diagnostics_enabled=1
        " echo "LSP diagnostics is enabled."
    endif
  else
    echo "LSP diagnostics is not available."
  endif
endfunction

" Record the initial (enabled) state once per buffer.
function! InitializeDiagnosticsLSP()
  if exists(":LspDocumentDiagnostics") && !exists("b:lsp_diagnostics_enabled")
    let b:lsp_diagnostics_enabled=1
  endif
endfunction

augroup InitDiagnosticsLSP
  autocmd!
  autocmd BufEnter * call InitializeDiagnosticsLSP()
augroup END

augroup ResetCursorShape
  autocmd!
  " Reset cursor on startup
  autocmd VimEnter * :normal :startinsert :stopinsert 
augroup END

augroup AdaptColorScheme
  autocmd!
  autocmd ColorScheme * call HiNoneBG()
  autocmd ColorScheme * call HiClear()
  " Must run before vim-lsp: its defaults are hlexists-guarded, ours win.
  autocmd ColorScheme * call SetPlugHi()
augroup END

augroup SetFormatOptions
  autocmd!
  " Format options.
  " autocmd Filetype * setlocal fo=tcq1lnp
  autocmd Filetype * setlocal fo-=r fo-=o
augroup END
