" see also
" http://blog.muuny-blue.info/c95d62c68196b2d0c1c1de8c7eeb6d50.html

if &shell =~# 'fish$'
    set shell=sh
endif

if &compatible
  set nocompatible
endif

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = expand('$HOME') . '/.pyenv/versions/py3neovim/bin/python'
let g:ruby_host_prog = '~/.rbenv/versions/2.3.0/bin/neovim-ruby-host'

augroup MyAutoCmd
  autocmd!
augroup END

let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir = s:dein_cache_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

runtime! options.rc.vim
runtime! keymap.rc.vim
runtime! utils.rc.vim
