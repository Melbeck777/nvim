return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.default,
				numbers = "buffer_id",
				close_command = "bdelete! %d",
				right_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "",
					style = "icon",
				},
				buffer_close = "",
				modified_icon = "● ",
				close_icon = " ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",

				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icons = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				duplicates_across_groups = true,
				move_wrasp_at_ends = true,
				separator_style = "thick",
			},
		})
	end,
}
