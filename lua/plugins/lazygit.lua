-- lua/plugins/lazygit.lua
-- Neovim から lazygit を快適に使うための設定
-- プラグイン: https://github.com/kdheepak/lazygit.nvim

return {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        -- キーマップは別ファイルで管理したい場合は、この配列を空にしてOK
        -- 例: { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
    init = function()
        -- 浮動ウィンドウ関連
        vim.g.lazygit_floating_window_winblend = 10         -- 透明度
        vim.g.lazygit_floating_window_scaling_factor = 0.95 -- 画面に対する比率
        vim.g.lazygit_floating_window_use_plenary = 0       -- 0: NeovimのAPIで描画
        -- 例: lua/plugins/lazygit.lua の init または config で
        vim.g.lazygit_floating_window_border_chars = { "+", "-", "+", "|", "+", "-", "+", "|" }

        --vim.g.lazygit_floating_window_border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
        -- Neovim からファイルを開き直す
        vim.g.lazygit_use_neovim_remote = 1

        -- LazyGit 側の設定ファイルの場所（必要に応じて調整）
        vim.g.lazygit_config_file_path = { vim.fn.expand("~/.config/lazygit/config.yml") }

        -- 端末・OS によってはクライアント指定が必要な場合あり
        -- vim.g.lazygit_use_custom_config_file_path = 1

        -- 端末を tmux 連携させたい場合の例（必要なければ削除）
        -- vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    end,
    config = function()
        -- Telescope 連携を使う場合（任意）
        -- require("telescope").load_extension("lazygit")

        -- コマンドで直接開けます:
        -- :LazyGit
        -- :LazyGitCurrentFile
        -- :LazyGitConfig
    end,
}
