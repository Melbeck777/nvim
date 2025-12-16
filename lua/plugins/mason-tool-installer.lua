--lua/plugins/mason-tool-instraller.lua
return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason").setup()
        require("mason-tool-installer").setup({
            -- ensure_installed = {
            --     "pyright", "ruff", "black",
            -- },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
