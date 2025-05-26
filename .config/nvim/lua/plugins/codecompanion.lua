return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/mcphub.nvim",
        {
            "ravitemer/mcphub.nvim", -- Manage MCP servers
            cmd = "MCPHub",
            build = "npm install -g mcp-hub@latest",
            config = true,
        },
    },
    opts = {
        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    make_vars = true,
                    make_slash_commands = true,
                    show_result_in_chat = true
                }
            }
        },
        opts = {
            language = "Japanese",
        }
    }
}
