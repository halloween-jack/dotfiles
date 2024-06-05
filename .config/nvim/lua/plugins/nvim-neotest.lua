return {
	"nvim-neotest/neotest",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"vim-test/vim-test",
		"nvim-neotest/neotest-plenary",
		"zidhuss/neotest-minitest",
		"nvim-neotest/neotest-vim-test",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-minitest"),
				require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
			},
		})
	end,
}
