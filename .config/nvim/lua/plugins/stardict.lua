return {
	"halloween-jack/stardict.nvim",
	keys = {
		{
			"<leader>sc",
			mode = "n",
			function()
				require("stardict").show_cursor()
			end,
			{
				dec = "show cursor's word result",
				silent = true,
			},
		},
	},
}
