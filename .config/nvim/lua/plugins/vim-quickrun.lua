return {
	"thinca/vim-quickrun",
	dependences = {
		{
			"lambdalisue/vim-quickrun-neovim-job",
			init = function()
				vim.g.quickrun_config = {
					markdown = {
						outputter = "browser",
						command = ":PrevimOpen",
						exec = "%c",
					},
					_ = {
						runner = "neovim_job",
					},
				}
			end,
		},
	},
	keys = {
		{
			"<leader>r",
			mode = { "n" },
			function()
				vim.cmd("QuickRun")
			end,
			{
				silent = true,
			},
		},
	},
}
