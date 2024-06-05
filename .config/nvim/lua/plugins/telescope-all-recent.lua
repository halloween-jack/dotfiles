return {
	"prochri/telescope-all-recent.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"kkharji/sqlite.lua",
		-- optional, if using telescope for vim.ui.select
		-- "stevearc/dressing.nvim"
	},
	opts = {
		-- your config goes here
	},
	keys = {
		{
			",dd",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n",
		},
		{
			",df",
			function()
				require("telescope.builtin").find_files({
					search_dirs = { vim.fn.expand("%:h") },
				})
			end,
			mode = "n",
		},
		{
			",d`",
			function()
				require("telescope.builtin").find_files({
					cwd = "~/.config/nvim/",
				})
			end,
			mode = "n",
		},
		{
			",db",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = "n",
		},
		{
			",d/",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = "n",
		},
		{
			",dt",
			function()
				require("telescope.builtin").filetypes()
			end,
			mode = "n",
		},
		{
			",d.",
			function()
				require("telescope.builtin").resume()
			end,
			mode = "n",
		},
	},
}
