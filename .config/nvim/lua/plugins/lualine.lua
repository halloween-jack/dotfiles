return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		options = {
			theme = "seoul256",
		},
	},
}
