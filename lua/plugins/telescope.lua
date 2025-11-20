-- %LOCALAPPDATA%/nvim/lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function() return vim.fn.executable("make") == 1 end
        },
    },
    opts = function()
        return require("config.telescope").opts()
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        -- pcall(telescope.load_extension, "fzf")
    end,
}
