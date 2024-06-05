return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	build = "make install_jsregexp",
	keys = {
		{
			"<C-k>",
			function()
				local ls = require("luasnip")
				ls.expand()
				--if ls.expand_or_jumpable() then
				--	ls.expand_or_jump()
				--end
			end,
			mode = { "i" },
			{
				expr = true,
				silent = true,
			},
		},
		{
			"<C-f>",
			function()
				require("luasnip").jump(1)
			end,
			mode = { "i", "s" },
			{
				silent = true,
			},
		},
		{
			"<C-b>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
			{
				silent = true,
			},
		},
		{
			"<C-e>",
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			mode = { "i", "s" },
			{
				silent = true,
			},
		},
	},
	config = function()
		require("luasnip/loaders/from_vscode").lazy_load()
	end,
}
