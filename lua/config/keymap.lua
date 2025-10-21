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

local Terminal = require("toggleterm.terminal").Terminal
local function open_new_term(direction)
    direction = direction or "float"
  local term = Terminal:new({
    direction = direction,
    close_on_exit = true,
  })
  term:open()
end



-- Leader mappings
map("n", "<leader>tt", function()
  load_then("toggleterm.nvim", function()
    open_new_term("float")            -- ← vim.cmd は不要
  end)
end, opts({ desc = "Toggle terminal" }))

map("n", "<leader>tv", function()
  load_then("toggleterm.nvim", function()  -- ← repo ではなく "toggleterm.nvim"
    open_new_term("vertical")            -- ← vim.cmd は不要
  end)
end, opts({ desc = "Terminal Vertical" }))
-- 例: keymap.lua
-- load_then は「プラグイン名」で呼ぶ。vim.cmd は使わず関数を直接呼ぶ。

map("n", "<leader>th", function()
  load_then("toggleterm.nvim", function()  -- ← repo ではなく "toggleterm.nvim"
    open_new_term("horizontal")            -- ← vim.cmd は不要
  end)
end, opts({ desc = "Terminal Horizontal" }))

-- 端末バッファから抜ける
map("t", "<esc>", [[<C-\><C-n>]], opts())

-- LSP 共通（LspAttach でバッファローカルに張る）
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local bmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end
    bmap("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    bmap("n", "gr", vim.lsp.buf.references, "References")
    bmap("n", "K",  vim.lsp.buf.hover, "Hover")
    bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    bmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    bmap("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, "Format")
  end,
})
