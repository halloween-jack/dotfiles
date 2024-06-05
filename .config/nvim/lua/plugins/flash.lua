return {
	"folke/flash.nvim",
	event = "VeryLazy",
	keys = {
		{
			",f",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			",s",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash",
		},
	},
}
