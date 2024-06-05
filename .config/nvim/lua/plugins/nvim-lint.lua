return {
	"mfussenegger/nvim-lint",
	enabled = true, -- none-ls.nvimの導入により無効化
	config = function()
		local phpstan = require("lint").linters.phpstan
		phpstan.args = {
			"analyze",
			"--error-format=json",
			"--no-progress",
			"--level=9",
		}
		require("lint").linters_by_ft = {
			go = { "golangcilint" },
			css = { "stylelint" },
			scss = { "stylelint" },
			php = { "phpstan" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
