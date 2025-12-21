return {
	"yuki-yano/fuzzy-motion.vim",
	dependencies = {
		"vim-denops/denops.vim",
	},
	init = function()
		vim.g.fuzzy_motion_chars = "asdfghjklqwertyuiopzxcvbnm"
	end,
}
