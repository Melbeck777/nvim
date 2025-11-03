-- plugins/conform.lua
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                markdown = { "prettier" },
                yaml = { "prettier" },
                python = { "ruff_format", "black" },
                markdown = { "prettied", "prettier" },
                go = { "gofumpt", "goimports" },
            },
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                require("conform").format({ bufnr = args.buf, lsp_fallback = true })
            end,
        })
    end,
}
