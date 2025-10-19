-- %LOCALAPPDATA%/nvim/lua/plugins/tokyonight.lua
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- "storm" | "moon" | "night" | "day"
		transparent = false,
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
