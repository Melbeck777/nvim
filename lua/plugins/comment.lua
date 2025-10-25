return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- commentstring を優先して言語ごとの記号を自動選択
    -- 何もいじらなくても即使えます
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
