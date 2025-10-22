return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    update_focused_file = { enable = true },
    -- 追記後（ツリーガイドと枝アイコンを有効化）
    renderer = {
      highlight_git = true,
      group_empty = true,
      indent_markers = {
        enable = true,
        inline_arrows = false, -- 矢印を縦線と同列にしない（好みで true/false）
        icons = {
          corner = "└",
          edge   = "│",
          item   = "├",
          bottom = "─",
          none   = " ",
        },
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "● ",
          symlink = "↗ ",
          folder = {
            default = "▸ ",
            open = "▾ ",
            empty = "▸ ",
            empty_open = "▾ ",
            symlink = "↗ ",
            symlink_open = "↘ ",
            arrow_closed = "▸",
            arrow_open = "▾"
          },
          git = {
            unstaged = "!",
            staged = "+",
            unmerged = "",
            renamed = "»",
            untracked = "?",
            deleted = "×",
            ignored = "·",
          },
        },
      },
    },

    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = { hint = "", info = "", warning = "", error = "" },
    },
    git = {
      enable = true,
      ignore = false,  -- .gitignore を非表示にしたくない場合
      timeout = 400,
    },
    filesystem_watchers = { enable = true },
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
