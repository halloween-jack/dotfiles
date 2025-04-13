return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "folke/neoconf.nvim",
        {
            "neovim/nvim-lspconfig",
            dependencies = { 'saghen/blink.cmp' },
            init = function()
                -- Change diagnostic symbols in the sign column (gutter)
                -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
                local signs = { Error = "■ ", Warn = "■ ", Hint = "● ", Info = "■ " }
                for type, icon in pairs(signs) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end
            end,
        },
    },
    config = function()
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {
                buf = bufnr,
            })

            -- Mappings.
            local opts = { noremap = true, silent = true }
            buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
            --buf_set_keymap("n", "gd", [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]], opts)
            buf_set_keymap("n", "gl", "<Cmd>Lspsaga peek_definition<CR>", opts)
            buf_set_keymap("n", "<C-w>gd", "<Cmd>split | lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
            --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap("n", "gi", [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]], opts)
            buf_set_keymap("n", "<C-w>gi", "<Cmd>split | lua vim.lsp.buf.implementation()<CR>", opts)
            buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
            buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
            buf_set_keymap(
                "n",
                "<space>wl",
                "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                opts
            )
            buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
            buf_set_keymap("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
            buf_set_keymap("v", "<space>ca", "<cmd>Lspsaga range_code_action<CR>", opts)
            buf_set_keymap("n", "<space>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
            buf_set_keymap("n", "<space>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
            buf_set_keymap("n", "gr", "<cmd>Lspsaga finder<cr>", opts)
            buf_set_keymap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
            --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
            --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
            buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
            buf_set_keymap("n", "<space>gl", [[<cmd>lua require('telescope.builtin').diagnostics()<cr>]], opts)
            buf_set_keymap("n", "<space>l", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], opts)
            buf_set_keymap(
                "n",
                "<space>wl",
                [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]],
                opts
            )

            --buf_set_keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts)
            --buf_set_keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)

            -- Set some keybinds conditional on server capabilities
            if client.server_capabilities.documentFormattingProvider then
                buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
            end

            -- Server capabilities spec:
            -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = vim.lsp.buf.document_highlight,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Document Highlight",
                })
                vim.api.nvim_create_autocmd("CursorMoved", {
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Clear All the References",
                })
            end
        end

        require("mason").setup({
            ui = {
                border = "single",
            },
        })
        require("neoconf").setup({
            import = {
                coc = false,
            },
        })

        local ensure_installed = {
            "rust_analyzer",
            "ts_ls",
            "clangd",
            "gopls",
            "lua_ls",
            --"ruby_lsp",
            "phpactor",
        }
        require("mason-lspconfig").setup({
            ensure_installed = ensure_installed,
        })

        -- neovim 0.11 LSP settings
        vim.diagnostic.config({
            virtual_lines = true,
        })

        vim.lsp.config('*', {
            on_attach = on_attach
        })

        vim.lsp.config.rust_analyzer = {
            on_attach = on_attach, -- FIXME: `vim.lsp.config('*')`での設定が何故か有効にならないため明示的に設定する
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                    completion = {
                        fullFunctionSignatures = {
                            enable = true,
                        },
                    },
                },
            }
        }

        vim.lsp.config.ts_ls = {
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = false,
                        includeInlayFunctionParameterTypeHints = false,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = false,
                        includeInlayFunctionParameterTypeHints = false,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
            },
        }

        vim.lsp.config.clangd = {
            capabilities = {
                offsetEncoding = "utf-8"
            }
        }

        vim.lsp.config.lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        }

        vim.lsp.config.gopls = {

            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
        }

        vim.lsp.config.ruby_lsp = {
            init_options = {
                enabledFeatures = {
                    "documentSymbol",
                    "documentLink",
                    "hover",
                    "foldingRanges",
                    "selectionRanges",
                    "semanticHighlighting",
                    "signatureHelp",
                    "formatting",
                    "onTypeFormatting",
                    "diagnostics",
                    "codeActions",
                    "codeActionResolve",
                    "documentHighlight",
                    "inlayHints",
                    "completion",
                    "codeLens",
                },
                experimentalFeaturesEnabled = true,
            },
        }

        -- vim.lsp.config.phpactor = {
        --     init_options = {
        --         ["language_server_phpstan.enabled"] = true,
        --         ["language_server_phpstan.bin"] = "~/.local/share/nvim/mason/bin/phpstan",
        --         ["language_server_phpstan.level"] = 9,
        --     },
        -- }

        vim.lsp.enable(ensure_installed)
        vim.lsp.inlay_hint.enable(true)
    end,
}
