-- lua/config/ddc.lua
local M = {}

function M.setup()
    local fn = vim.fn
    local luasnip = require("luasnip")

    vim.opt.completeopt = "menuone,noinsert,noselect"

    -- UI・sources
    fn["ddc#custom#patch_global"]({
        ui = "native",
        autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP" },
        autoCompleteDelay = 50,
        sources = { "lsp", "file", "around" },
        sourceOptions = {
            _ = {
                matchers = { "matcher_head" },
                sorters  = { "sorter_rank" },
                -- converters = { "converter_fuzzy" },
            },
            lsp = {
                mark = "[LSP]",
                matchers = { "matcher_head" },
                forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
            },
            file = {
                mark = "[Path]",
                isVolatile = true,
                forceCompletionPattern = [[\S/\S*]],
            },
            around = { mark = "[Buf]" },
            cmdline = { mark = "[Cmd]" },
            ["cmdline-history"] = { mark = "[Hist]" },
            path = { mark = "[Path]" },
        },
        sourceParams = {
            lsp = {
                -- スニペット連携（必要な場合のみ）
                snippetEngine = fn["denops#callback#register"](function(body)
                    return luasnip.lsp_expand(body)
                end),
                enableResolveItem = true,
                enableAdditionalTextEdit = true,
                confirmBehavior = "replace",
            },
        },
        cmdlineSources = {
            [":"] = { "cmdline", "file" },
            ["/"] = { "around" },
            ["?"] = { "around" },
        },
    })

    -- 対象言語で lsp を優先（既存ロジック維持）
    local ft_list = { "lua", "python", "go", "cpp", "c", "java", "kotlin", "html", "javascript", "typescript" }
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft_list,
        callback = function()
            fn["ddc#custom#patch_buffer"]({
                sources = { "lsp", "around", "file" },
                -- 任意: Lua で識別子緩める等
                -- sourceOptions = { lsp = { keywordPattern = [[\k\+]] } },
            })
        end,
    })

    -- 有効化（引数なしでOK）
    fn["ddc#enable"]()
    fn["ddc#enable_cmdline_completion"]()

    -- 既存のキーマップは暫定維持（最終的に keymap.lua へ）
    vim.keymap.set("i", "<C-Space>", function()
        fn["ddc#map#manual_complete"]()
    end, { silent = true })

    vim.keymap.set("i", "<CR>", function()
        if fn["ddc#visible"]() == 1 then
            return fn["ddc#map#confirm"]()
        else
            return "\r"
        end
    end, { expr = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<Space>t", function()
        if fn["ddc#visible"]() == 1 then
            return fn["ddc#map#select_next"]()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            return ""
        end
        return "\t"
    end, { expr = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<Space>T", function()
        if fn["ddc#visible"]() == 1 then
            return fn["ddc#map#select_prev"]()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
            return ""
        end
        return ""
    end, { expr = true, silent = true })
end

return M
