nnoremap [denite] <Nop>
nmap ,d [denite]

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup',
      \ '-g', '', '--ignore-dir', 'node_modules'])

call denite#custom#map('normal', "<C-j>", '<denite:do_action:split>')
call denite#custom#map('normal', "<C-l>", '<denite:do_action:vsplit>')

call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', "<C-j>", '<denite:do_action:split>')
call denite#custom#map('insert', "<C-l>", '<denite:do_action:vsplit>')
call denite#custom#map(
      \ 'insert',
      \ 'jj',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-[>',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)

" Add custom menus
let s:menus = {}

let s:menus.env = {
  \ 'description': 'Edit your import env configuration'
  \ }
let s:menus.env.file_candidates = [
  \ ['zshrc', '~/.config/zsh/.zshrc'],
  \ ['zshenv', '~/.zshenv'],
  \ ['nvim', '~/.config/nvim/'],
  \ ]
call denite#custom#var('menu', 'menus', s:menus)

