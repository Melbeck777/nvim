-- lua/plugins/autolist.lua
return {
	"gaoDean/autolist.nvim",
	ft = { "markdown", "text", "tex", "plaintex", "norg" },
	opts = {
		lists = {
			marker = { "-", "*", "+" },
			checkbox = { " ", "x" },
			auto_detect = true,
			cycle = true,
			indent = 2,
		},
		colon = { ":", ";" },
	},
	config = function(_, opts)
		require("autolist").setup(opts)
	end,
}
