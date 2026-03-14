return {
	"dhruvasagar/vim-table-mode",
	-- table-mode はファイルタイプを問わず使うことが多いので常時ロードでもOK
	-- event = "VeryLazy",

	init = function()
		-- 自動で有効化しない（必要な時だけ :TableModeToggle でON）
		vim.g.table_mode_autostart = 0

		-- Markdown を主戦場にするならこれが無難
		vim.g.table_mode_corner = "|"
		vim.g.table_mode_separator = "|"

		-- フォーマットを崩したくないなら 1、常に整形したいなら 0 でも良い
		vim.g.table_mode_syntax = 1

		-- 罫線のスタイル（お好み）
		-- vim.g.table_mode_corner_corner = "+"
		-- vim.g.table_mode_header_fillchar = "-"

		-- 既定のマッピングを使うなら 0 のままでOK
		-- vim.g.table_mode_disable_mappings = 0
	end,

	config = function()
		-- よく使うのを Lua 側でショートカット
		vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "TableMode toggle" })
		vim.keymap.set("n", "<leader>tr", "<cmd>TableModeRealign<CR>", { desc = "TableMode realign" })
	end,
}
