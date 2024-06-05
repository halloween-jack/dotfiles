-- option settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.list = true
vim.o.listchars = "tab:>-,trail:-,nbsp:%,extends:>,precedes:<"
vim.o.expandtab = true
vim.opt.clipboard:append({ "unnamedplus" })
vim.o.spell = true
vim.o.updatetime = 500

-- netrw settings
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 30

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- setting global keymaps
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- TODO: Jumplist mutations
-- vim.keymap.set("n", "k", function()
-- 	if vim.v.count > 5 then
-- 		return "m'"
-- 	end
-- end, {
-- 	expr = true,
-- })

-- インサートモードを抜けた時にUSに切り替える
if vim.fn.executable("fcitx5") == 1 then
	vim.cmd([[
        augroup Fcitx
           autocmd!
           autocmd InsertLeave,CmdlineLeave * :call system('fcitx5-remote -c')
        augroup END
    ]])
end

-- 自動的にディレクトリ作成
vim.cmd([[
augroup vimrc-auto-mkdir
  autocmd!
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	ui = {
		border = "single",
	},
})
