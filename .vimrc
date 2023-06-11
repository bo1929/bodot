let plugins_path=$HOME . '/.vim/plugins.vim'
if filereadable(plugins_path)
  exec 'source' . plugins_path
endif

let misc_path=$HOME . '/.vim/misc.vim'
if filereadable(misc_path)
  exec 'source' . misc_path
endif

let mappings_path=$HOME . '/.vim/mappings.vim'
if filereadable(mappings_path)
  exec 'source' . mappings_path
endif

let settings_path=$HOME . '/.vim/settings.vim'
if filereadable(settings_path)
  exec 'source' . settings_path
endif
