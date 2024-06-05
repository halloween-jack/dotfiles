return {
	"vim-test/vim-test",
	init = function()
		vim.g["test#strategy"] = "neovim"
		if vim.fn.has("nvim") then
			vim.keymap.set("t", "<C-o>", "<C-><C-n>", nil)
		end
	end,
	keys = {
		{
			"<C-o>",
			"<C-\\><C-n>",
			mode = "t",
			{
				silent = true,
			},
		},
		{
			",tn",
			function()
				vim.cmd("TestNearest")
			end,
			mode = "n",
			{
				silent = true,
			},
		},
		{
			",tf",
			function()
				vim.cmd("TestFile")
			end,
			mode = "n",
			{
				silent = true,
			},
		},
		{
			",ts",
			function()
				vim.cmd("TestSuite")
			end,
			mode = "n",
			{
				silent = true,
			},
		},
		{
			",tl",
			function()
				vim.cmd("TestLast")
			end,
			mode = "n",
			{
				silent = true,
			},
		},
		{
			",tg",
			function()
				vim.cmd("TestVisit")
			end,
			mode = "n",
			{
				silent = true,
			},
		},
	},
}
