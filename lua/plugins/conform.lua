-- plugins/conform.lua
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				yaml = { "prettierd" },
				python = { "ruff_format" },
				markdown = { "prettierd", "injected", stop_after_first = false },
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
