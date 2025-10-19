return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    update_focused_file = { enable = true },
    renderer = { highlight_git = true, group_empty = true },
    filters = { dotfiles = false },
    view = { width = 35, side = "left" },

    on_attach = function(bufnr)
      local ok, api = pcall(require, "nvim-tree.api")
      if ok and api and api.config and api.config.mappings
         and type(api.config.mappings.default_on_attach) == "function" then
        api.config.mappings.default_on_attach(bufnr)
      end
      -- 存在しない場合でもエラーにしない
      pcall(vim.keymap.del, "n", "<C-\\>", { buffer = bufnr })
    end,
  },

  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
    { "<leader>o", "<cmd>NvimTreeFocus<cr>",  desc = "NvimTree Focus"  },
  },

  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
