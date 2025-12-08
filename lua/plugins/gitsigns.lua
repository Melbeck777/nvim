-- lua/plugins/git.lua
return {
	-- gitsigns（行ごとの差分/ブレイム/ステージ等）
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = false, -- true にすると行ブレイム常時表示
		},
	},
	-- git-blame（軽量なインライン blame）
	{
		"f-person/git-blame.nvim",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			-- 必要時だけトグルして使うのが快適
			vim.g.gitblame_enabled = 0
		end,
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Git blame toggle" },
		},
	},
}
