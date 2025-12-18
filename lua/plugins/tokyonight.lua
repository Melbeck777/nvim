-- %LOCALAPPDATA%/nvim/lua/plugins/tokyonight.lua
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night", -- "storm" | "moon" | "night" | "day"
		on_highlights = function(h1, c)
			h1.WinSeparator = { fg = "#3b4261", bg = "NONE" }
			h1.FloatBorder = { fg = "#3b4261", bg = c.bg }
			h1.NormalFloat = { fg = c.fg, bg = c.bg_dark }
		end,
		transparent = true,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
