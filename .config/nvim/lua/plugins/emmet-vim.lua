return {
	"mattn/emmet-vim",
	init = function()
		vim.g.user_emmet_settings = {
			["javascript.jsx"] = {
				extends = "jsx",
			},
			typescript = {
				extends = "jsx",
			},
		}
	end,
}
