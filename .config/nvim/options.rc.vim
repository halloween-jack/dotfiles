set backspace=indent,eol,start
set showmatch
set tabstop=2
set shiftwidth=2
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set autoindent
set expandtab
set wildmenu
set fileformats=unix,dos,mac
source $VIMRUNTIME/macros/matchit.vim " Vimの%を拡張 cf. http://nanasi.jp/articles/vim/matchit_vim.html

" statusline setting
set laststatus=2 " ステータスラインを常に表示
set statusline=%f\ %h%w%m%r\

" crontabで編集が保存できない問題を回避
set backupskip=/tmp/*,/private/tmp/*
