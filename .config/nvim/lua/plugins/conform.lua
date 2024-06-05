return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = function()
		local opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				php = { "pint" },
				blade = { "blade-formatter", "rustywind" },
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 5000, lsp_fallback = true },
			--formatters = {
			--	biome = {
			--		inherit = true,
			--		args = { "--indent-style=space" },
			--	},
			--},
			--formatters = {
			--	pint = {
			--		meta = {
			--			url = "https://github.com/laravel/pint",
			--			description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
			--		},
			--		command = require("conform.util").find_executable({
			--			vim.fn.stdpath("data") .. "/mason/bin/pint",
			--			"vendor/bin/pint",
			--		}, "pint"),
			--		args = { "$FILENAME" },
			--		stdin = false,
			--	},
			--},
		}
		return opts
	end,
}
