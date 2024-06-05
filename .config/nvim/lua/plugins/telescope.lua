return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		-- keys = {
		-- 	{
		-- 		",dd",
		-- 		function()
		-- 			require("telescope.builtin").find_files()
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",df",
		-- 		function()
		-- 			require("telescope.builtin").find_files({
		-- 				search_dirs = { vim.fn.expand("%:h") },
		-- 			})
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",d`",
		-- 		function()
		-- 			require("telescope.builtin").find_files({
		-- 				cwd = "~/.config/nvim/",
		-- 			})
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",db",
		-- 		function()
		-- 			require("telescope.builtin").buffers()
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",d/",
		-- 		function()
		-- 			require("telescope.builtin").live_grep()
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",dt",
		-- 		function()
		-- 			require("telescope.builtin").filetypes()
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- 	{
		-- 		",d.",
		-- 		function()
		-- 			require("telescope.builtin").resume()
		-- 		end,
		-- 		mode = "n",
		-- 	},
		-- },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					layout_strategy = "flex",
					-- 可能ならneovim本体のapiで使用されているborderスタイルの値を使用したい
					-- border: single
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					mappings = {
						i = {
							["<C-l>"] = actions.select_vertical,
							["<C-j>"] = actions.select_horizontal,
						},
						n = {
							["q"] = actions.close,
							["<C-l>"] = actions.select_vertical,
							["<C-j>"] = actions.select_horizontal,
						},
					},
					file_ignore_patterns = {
						"node_modules/.*",
						"target/.*",
					},
					preview = {
						timeout = 100,
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
}
