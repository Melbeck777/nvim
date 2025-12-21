return {
	{
		"vim-denops/denops.vim",
		lazy = false,
	},
	{
		"lambdalisue/vim-kensaku",
		lazy = false,
		dependencies = {
			"vim-denops/denops.vim",
		},
	},

	{
		"lambdalisue/kensaku-search.vim",
		lazy = false,
		dependencies = {
			"lambdalisue/vim-kensaku",
		},
	},
}
