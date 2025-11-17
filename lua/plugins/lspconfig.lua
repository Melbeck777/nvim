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
                    "ts_ls", -- 修正: "ts_ls" はNG
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

            -- 診断UIはここで
            vim.diagnostic.config({
                virtual_text = { spacing = 2, prefix = "●" },
                float = { border = "rounded" },
                severity_sort = true,
                signs = true,
            })

            -- LspAttach で keymap.lua に委譲（バッファローカル）
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
                callback = function(args)
                    pcall(require, "keymap") -- 存在しない場合でも落ちないように
                    if package.loaded["keymap"] then
                        require("keymap").lsp_on_attach(args.buf)
                    end
                end,
            })

            -- インストール済みを一括 setup（個別差分は必要時に分岐）
            --            local servers = require("mason-lspconfig").get_installed_servers()
            --            for _, server_name in ipairs(servers) do
            --                local conf = { capabilities = capabilities }
            --                if server_name == "lua_ls" then
            --                    conf.settings = {
            --                        Lua = {
            --                            runtime = { version = "LuaJIT" },
            --                            diagnostics = { globals = { "vim" } },
            --                            workspace = { checkThirdParty = false },
            --                            telemetry = { enable = false },
            --                        },
            --                    }
            --                end
            --                print(server_name, vim.lsp[server_name], conf)
            --                vim.lsp[server_name].setup(conf)
            --            end
        end,
    },
}
