-- %LOCALAPPDATA%/nvim/lua/plugins/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, -- 起動直後から使いたい場合
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		disable_netrw = true,
		hijack_netrw = true,
		update_focused_file = { enable = true },
		renderer = { highlight_git = true, group_empty = true },
		filters = { dotfiles = false },
		view = { width = 35, side = "left" },
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
		{ "<leader>o", "<cmd>NvimTreeFocus<cr>",  desc = "NvimTree Focus"  },
	},
}
