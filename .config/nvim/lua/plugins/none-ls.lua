return {
    "nvimtools/none-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    -- MEMO: null-lsのコミュニティフォークとあるがnvimtoolsグループが個人によって運用されているように見えて怪しいのでしばらく使わないようにする
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local async_formatting = function(bufnr)
            bufnr = bufnr or vim.api.nvim_get_current_buf()

            vim.lsp.buf_request(
                bufnr,
                "textDocument/formatting",
                vim.lsp.util.make_formatting_params({}),
                function(err, res, ctx)
                    if err then
                        local err_msg = type(err) == "string" and err or err.message
                        -- you can modify the log message / level (or ignore it completely)
                        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                        return
                    end

                    -- don't apply results if buffer is unloaded or has been modified
                    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                        return
                    end

                    if res then
                        local client = vim.lsp.get_client_by_id(ctx.client_id)
                        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                        vim.api.nvim_buf_call(bufnr, function()
                            vim.cmd("silent noautocmd update")
                        end)
                    end
                end
            )
        end

        local null_ls = require("null-ls")

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                -- textlintのpresetはnpmなどでインストールする必要があるが、管理方法がMasonとnpmで異なってしまうのが気持ち悪さがある
                -- null_ls.builtins.diagnostics.textlint.with({
                --   extra_filetypes = { "html", "markdown" },
                -- }),

                -- deno_fmtをprettierより優先する
                -- html, cssなどはdeno_fmtが対応していないため競合する言語のみdisableとする
                -- null_ls.builtins.formatting.prettier.with({
                -- 	disabled_filetypes = {
                -- 		"javascript",
                -- 		"javascriptreact",
                -- 		"json",
                -- 		"jsonc",
                -- 		"markdown",
                -- 		"typescript",
                -- 		"typescriptreact",
                -- 	},
                -- }),
                -- null_ls.builtins.formatting.deno_fmt,
                -- ref. https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Source-specific-Configuration#rust
                null_ls.builtins.formatting.rustfmt.with({
                    extra_args = function(params)
                        local Path = require("plenary.path")
                        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

                        if cargo_toml:exists() and cargo_toml:is_file() then
                            for _, line in ipairs(cargo_toml:readlines()) do
                                local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                                if edition then
                                    return { "--edition=" .. edition }
                                end
                            end
                        end
                        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
                        return { "--edition=2021" }
                    end,
                }),
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.buf,
                null_ls.builtins.formatting.yamlfmt,
                null_ls.builtins.diagnostics.buf,
                null_ls.builtins.diagnostics.golangci_lint,
            },
            debug = false,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            --async_formatting(bufnr)
                            vim.lsp.buf.format({
                                async = false,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
