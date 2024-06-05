return {
	"nvimdev/lspsaga.nvim",
	depenedencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	opts = {
		ui = {
			winblend = 0,
			code_action = "●",
		},
		definition = {
			width = 0.9,
		},
		lightbulb = {
			enable = false,
			virtual_text = false,
		},
		diagnostic = {
			extend_relatedInformation = true,
		},
		callhierarchy = {
			keys = {
				toggle_or_req = "<CR>",
			},
		},
		finder = {
			right_width = 0.5,
			default = "ref+imp+def",
		},
	},
}
