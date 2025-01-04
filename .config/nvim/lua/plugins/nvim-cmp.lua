return {
    "hrsh7th/nvim-cmp",
    enabled = false,
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "f3fora/cmp-spell",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
    },
    opts = function()
        local lspkind = require("lspkind")
        local cmp = require("cmp")
        return {
            --preselect = cmp.PreselectMode.None,
            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            formatting = {
                format = lspkind.cmp_format({
                    with_text = true,
                    menu = {
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        spell = "[Spell]",
                        luasnip = "[LuaSnip]",
                    },
                }),
            },

            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<C-y>"] = cmp.config.disable,
            },

            -- You should specify your *installed* sources.
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "spell" },
            },

            window = {
                completion = {
                    border = "single",
                },
                documentation = {
                    border = "single",
                },
            },

            performance = {
                -- default value is 200.
                max_view_entries = 100,
            },
        }
    end,
}
