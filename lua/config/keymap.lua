-- lua/config/keymap.lua
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local api = vim.api
local function load_then(names, fn)
    local list = type(names) == "string" and { names } or names
    pcall(function()
        require("lazy").load({ plugins = list })
    end)
    if fn then
        fn()
    end -- ← これが必要
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

-- toggleterm setting
map("n", "<Space>tt", function()
    load_then("toggleterm.nvim", function()
        open_new_term("float")
    end)
end, opts({ desc = "Toggle terminal" }))

map("n", "<Space>tv", function()
    load_then("toggleterm.nvim", function()
        open_new_term("vertical")
    end)
end, opts({ desc = "Terminal Vertical" }))

map("n", "<Space>th", function()
    load_then("toggleterm.nvim", function()
        open_new_term("horizontal")
    end)
end, opts({ desc = "Terminal Horizontal" }))
map("t", "<esc>", [[<C-\><C-n>]], opts())

-- Move buffer
map("n", "<C-j>", "<C-w>j", opts())
map("n", "<C-h>", "<C-w>h", opts())
map("n", "<C-l>", "<C-w>l", opts())
map("n", "<C-k>", "<C-w>k", opts())

-- fuzzy-motion
map("n", "gs", "<cmd>FuzzyMotion<CR>", opts())
map("x", "gs", "<cmd>FuzzyMotion<CR>", opts())

-- lazy git
map("n", "<leader>g", ":LazyGit<CR>", opts())

-- diffの表示
map("n", "<Space>gd", "<cmd>DiffviewOpen<cr>", opts({ desc = "Diffview: repo/index VS Head" }))
map("n", "<Space>gD", "<cmd>DiffviewOpen HEAD~1..HEAD<cr>", opts({ desc = "Diffview: Head~1..HEAD" }))
map("n", "<Space>gh", "<cmd>DiffviewFileHistory %<cr>", opts({ desc = "Diffview: file history (%)" }))
map("n", "<Space>gq", "<cmd>DiffviewClose<cr>", opts({ desc = "Diffview: close" }))

-- lsp
autocmd("LspAttach", {
    callback = function(ev)
        local lsp_opts = opts({ buffer = ev.buf })
        map("n", "gD", vim.lsp.buf.declaration, lsp_opts)
        map("n", "gd", vim.lsp.buf.definition, lsp_opts)
        map("n", "K", vim.lsp.buf.hover, lsp_opts)
        map("n", "gi", vim.lsp.buf.implementation, lsp_opts)
        map("n", "<Space>k", vim.lsp.buf.signature_help, lsp_opts)
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, lsp_opts)
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, lsp_opts)
        map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, lsp_opts)
        map("n", "<leader>D", vim.lsp.buf.type_definition, lsp_opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, lsp_opts)
        map("n", "gr", vim.lsp.buf.references, lsp_opts)
        map("n", "<leader>e", vim.diagnostic.open_float, lsp_opts)
        map("n", "[d", vim.diagnostic.goto_prev, lsp_opts)
        map("n", "]d", vim.diagnostic.goto_next, lsp_opts)
        map("n", "<leader>q", vim.diagnostic.setloclist, lsp_opts)
    end,
})

local function bmap(bufnr, mode, lhs, rhs, opt)
    opt = opt or {}
    opt.buffer = bufnr
    map(mode, lhs, rhs, opt)
end

-- insertmode
autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "i", "<CR>", "<CR><cmd>AutolistNewBullet<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "i", "<BS>", "<BS><cmd>AutolistBackspace<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "i", "<Tab>", "<cmd>AutolistTab<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "i", "<S-Tab>", "<cmd>AutolistShiftTab<CR>", { silent = true })
    end,
})

-- normalmode
autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "n", "<Tab>", "<cmd>AutolistTab<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "n", "<S-Tab>", "<cmd>AutolistShiftTab<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "n", "gl", "<cmd>AutolistToggleCheckbox<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "n", "g>", "<cmd>AutolistCycle<CR>", { silent = true })
    end,
})

autocmd("FileType", {
    pattern = { "markdown", "text", "norg" },
    callback = function(args)
        local bufnr = args.buf
        bmap(bufnr, "n", "gr", "<cmd>AutolistRecalculate<CR>", { silent = true })
    end,
})

local fn = vim.fn
local function has_words_before()
    local line, col = unpack(api.nvim_win_get_cursor(0))
    if col == 0 then
        return true
    end
    local c = api.nvim_get_current_line():sub(col, col)
    return c:match("%s") ~= nil
end
local builtin = require("telescope.builtin")
local tcfg = require("config.telescope")

map("n", "<Space>ff", function()
    builtin.find_files()
end, opts({ desc = "Find files" }))
map("n", "<Space>fg", function()
    builtin.live_grep({
        additional_args = function(_)
            return tcfg.rg_args_flat({ pcre = true })
        end,
    })
end, opts({ desc = "Live grep" }))
map("n", "<Space>fb", function()
    builtin.buffers()
end, opts({ desc = "Buffers" }))
map("n", "<Space>fh", function()
    builtin.help_tags()
end, opts({ desc = "Help tags" }))
map("n", "<Space>fo", function()
    builtin.git_files()
end, opts({ desc = "Git files" }))

-- find multiply: パス正規表現で絞ってから本文検索する（config/grep_in.lua）
-- コマンドラインに出した状態で止めるので、そのままパス正規表現を打って <CR>
map("n", "<Space>fm", ":GrepIn ", { noremap = true, desc = "Find multiply: パス正規表現 → live_grep" })
map("n", "<Space>fM", ":GrepQf ", { noremap = true, desc = "Find multiply: パス正規表現 + 本文正規表現 → quickfix" })

map("i", "<Tab>", function()
    if fn.pumvisible() == 1 then
        return "<C-n>"
    elseif has_words_before() then
        return "<Tab>"
    else
        return fn["ddc#map#manual_complete"]()
    end
end, { expr = true, silent = true })

map("i", "<S-Tab>", function()
    if fn.pumvisible() == 1 then
        return "<C-p>"
    else
        return "<C-h>"
    end
end, { expr = true, silent = true })

local ok_pairs, npairs = pcall(require, "nvim-autopairs")
if ok_pairs and ok then
    map.set("i", "<CR>", function()
        local res = autolist.new()
        if res ~= "<CR>" then
            return res
        end
        return npairs.autopairs_cr()
    end, { expr = true, replace_keycodes = false, silent = true, desc = "Autolist + autopairs CR" })
end

-- find-cmdline
api.nvim_set_keymap("n", "<Space>:", "<cmd>FineCmdline<CR>", opts())

-- vim-kensaku
map("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { noremap = false, silent = true })
