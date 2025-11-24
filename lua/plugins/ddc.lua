-- lua/plugins/ddc.lua
return {
    {
        "Shougo/ddc.vim",
        event = "InsertEnter",
        priority = 1000,
        dependencies = {
            "vim-denops/denops.vim",
            "Shougo/ddc-ui-native",
            "uga-rosa/ddc-previewer-floating",

            -- sources
            "Shougo/ddc-source-lsp",
            "Shougo/ddc-source-around",
            "LumaKernel/ddc-source-file",

            --cmd
            "Shougo/ddc-source-cmdline",
            "Shougo/ddc-source-cmdline_history",

            -- filters
            "Shougo/ddc-rg",
            "tani/ddc-fuzzy",

            -- snippet
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",

            -- ddc ↔︎ nvim-lsp 橋渡し
            { "uga-rosa/ddc-nvim-lsp-setup", lazy = false }, -- ← 追加
            lazy = false,
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            pcall(function() require("ddc_nvim_lsp_setup").setup() end)
            require("config.ddc").setup()
        end,
    },
}
