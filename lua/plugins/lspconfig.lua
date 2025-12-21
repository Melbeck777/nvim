-- lua/plugins/lspconfig.lua
return {
	{ "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"ts_ls",
					"jsonls",
					"html",
					"cssls",
					"pyright",
					"gopls",
					"jdtls",
					"kotlin_language_server",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"Shougo/ddc.vim",
			{ "uga-rosa/ddc-nvim-lsp-setup", lazy = false }, -- 追加
		},
		config = function()
			local ok, ddc_cap = pcall(require, "ddc_nvim_lsp_setup")
			local capabilities = ok and ddc_cap.make_client_capabilities()
				or vim.lsp.protocol.make_client_capabilities()
			--local capabilities = require("ddc_nvim_lsp_setup").make_client_capabilities()

			vim.diagnostic.config({
				virtual_text = { spacing = 2, prefix = "●" },
				float = { border = "rounded" },
				severity_sort = true,
				signs = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(args)
					pcall(require, "keymap")
					if package.loaded["keymap"] then
						print(args.buf)
						require("keymap").lsp_on_attach(args.buf)
					end
				end,
			})
		end,
	},
}
