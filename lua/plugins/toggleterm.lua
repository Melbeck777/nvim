return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction       = "float",           -- 好みで horizontal/vertical でもOK
    size            = 15,
    start_in_insert = true,              -- 端末にすぐ入る
    close_on_exit   = false,             -- デバッグ中は false 推奨。安定後 true に戻す
    shell           = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
                      and "powershell.exe" or vim.o.shell,
    float_opts      = { border = "rounded" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
