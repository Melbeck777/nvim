return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	-- Optional dependencies
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
		},
	},
	keys = {
		{
			"<Space>e",
			function()
				vim.cmd.Oil()
			end,
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
