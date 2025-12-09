return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			--"nvim-mini/mini.icons",
			opts = {},
		},
	},
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	opts = function()
		return require("config.oil").opts()
	end,
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)
	end,
}
