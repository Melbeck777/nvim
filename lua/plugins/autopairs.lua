-- lua/plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = true,  -- treesitter連携
      fast_wrap = {},   -- 後からカッコで包む操作を追加
    })
    -- 日本語括弧を追加
    local Rule = require("nvim-autopairs.rule")
    npairs.add_rules({
      Rule("「", "」"),
      Rule("『", "』"),
    })
  end,
}
