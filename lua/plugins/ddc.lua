-- lua/plugins/ddc.lua
return {
    {
        "Shougo/ddc.vim",
        event = "InsertEnter",
        priority = 1000,
        dependencies = {
            "vim-denops/denops.vim",
            "Shougo/ddc-ui-native",

            -- sources
            "Shougo/ddc-source-lsp",
            "Shougo/ddc-source-around",
            "LumaKernel/ddc-source-file",

            -- cmdline（必要なら）
            "Shougo/ddc-source-cmdline",
            --"Shougo/ddc-source-cmdline-history",

            -- filters
            "Shougo/ddc-filter-matcher_head",
            "Shougo/ddc-filter-sorter_rank",
            --"Shougo/ddc-filter-converter_case", -- ← 使うなら追加

            -- snippet
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",

            -- ddc ↔︎ nvim-lsp 橋渡し
            { "uga-rosa/ddc-nvim-lsp-setup", lazy = false }, -- ← 追加
            lazy = false,
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            --require("ddc_nvim_lsp_setup").setup() -- ← これが通るようになる
            -- 失敗しても落とさない
            pcall(function() require("ddc_nvim_lsp_setup").setup() end)
            require("config.ddc").setup()
        end,
    },
}
