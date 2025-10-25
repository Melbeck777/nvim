-- lua/plugins/autolist.lua
return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text", "norg" },
  opts = {
    lists = {
      marker = { "-", "*", "+" },
      checkbox = { " ", "x" },
      auto_detect = true,
      cycle = true,
      indent = 2,
    },
    colon = true,
  },
  config = function(_, opts)
    require("autolist").setup(opts)
  end,
}
