-- lua/config/keymap.lua
local map = vim.keymap.set

local function load_then(names, fn)
  local list = type(names) == "string" and { names } or names
  pcall(function()
    require("lazy").load({ plugins = list })
  end)
  if fn then fn() end  -- ← これが必要
end

local function opts(extra)
  return vim.tbl_extend("force", { noremap = true, silent = true }, extra or {})
end

-- Leader mappings
map("n", "<leader>tt", function()
  load_then("akinsho/toggleterm.nvim", function()
    vim.cmd("ToggleTerm direction=float")
  end)
end, opts({ desc = "Toggle terminal" }))

map("n", "<leader>tv", function()
  load_then("akinsho/toggleterm.nvim", function()
    vim.cmd("ToggleTerm direction=vertical")
  end)
end, opts({ desc = "Terminal Vertical" }))

map("n", "<leader>th", function()
  load_then("akinsho/toggleterm.nvim", function()
    vim.cmd("ToggleTerm direction=horizontal")
  end)
end, opts({ desc = "Terminal Horizontal" }))

-- 端末バッファから抜ける
map("t", "<esc>", [[<C-\><C-n>]], opts())
