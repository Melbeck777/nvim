return {
	"VonHeikemen/fine-cmdline.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		local fine = require("fine-cmdline")

		fine.setup({
			popup = {
				border = {
					style = "rounded",
					text = { top = " Cmdline ", top_align = "left" },
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
		})
	end,
}
