-- lua/plugins/colorizer.lua
return {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("colorizer").setup({
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                tailwind = true,
                mode = "virtualtext",
                virtualtext = "■",
            },
            buftypes = { "terminal", "nofile", "prompt" },
        })
    end,
}
