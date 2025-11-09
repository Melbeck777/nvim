-- plugins/markdown-preview.lua
return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "md", "markdown.mdx", "rmarkdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },

    init = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_command_for_global = 1
        vim.g.mkdp_open_to_the_world = false
        vim.g.mkdp_browser = "" -- 既定ブラウザに任せる
        vim.g.mkdp_port = ""
        vim.g.mkdp_theme = "system"
        vim.g.mkdp_filetypes = { "markdown" }
    end,

    -- yarn install → 失敗したら npm install にフォールバック
    build = function()
        local app = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"

        local function run(cmd, args)
            if vim.system then
                local res = vim.system(vim.list_extend({ cmd }, args), { cwd = app }):wait()
                return res.code == 0, res.stderr or ""
            else
                -- Neovim 0.9 フォールバック
                local code = vim.fn.jobwait({ vim.fn.jobstart({ cmd, unpack(args) }, { cwd = app }) }, 600000)[1]
                return code == 0, ""
            end
        end

        -- まず yarn
        local ok, err = run("yarn", { "install" })
        if not ok then
            -- npm install にフォールバック
            ok, err = run("npm", { "install", "--no-audit", "--no-fund" })
        end
        if not ok then
            error("markdown-preview.nvim: dependency install failed:\n" .. err)
        end
    end,

    keys = {
        { "<leader>mp", "<cmd>MarkdownPreview<cr>",       desc = "Markdown Preview",        mode = "n" },
        { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>",   desc = "Markdown Preview Stop",   mode = "n" },
        { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle", mode = "n" },
    },
}
