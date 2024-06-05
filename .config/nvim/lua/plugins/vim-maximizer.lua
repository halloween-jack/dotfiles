return {
	"szw/vim-maximizer",
	keys = {
		{
			"<C-w>f",
			mode = { "n", "x", "o" },
			function()
				vim.cmd("MaximizerToggle")
			end,
			desc = "Vim Maximizer",
		},
	},
}
