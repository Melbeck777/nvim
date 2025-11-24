-- lua/config/ddc.lua
local M = {}

function M.setup()
    local fn = vim.fn
    local luasnip = require("luasnip")

    vim.opt.completeopt = "menuone,noinsert,noselect"

    fn["ddc#custom#patch_global"]({
        ui = "native",
        autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged" },
        autoCompleteDelay = 50,

        sources = { "lsp", "rg", "file", "around" },

        sourceOptions = {
            _ = {
                matchers              = { "matcher_fuzzy" },
                sorters               = { "sorter_fuzzy" },
                converters            = { "converter_fuzzy" },
                minAutoCompleteLength = 1,
            },
            lsp = {
                mark = "[LSP]",
                matchers = { "matcher_fuzzy" },
                forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
                maxItems = 15,
            },
            file = {
                mark = "[Path]",
                isVolatile = true,
                forceCompletionPattern = [[\S/\S*]],
            },
            around = { mark = "[Buf]" },
            rg = { mark = "[rg]" },
            cmdline = { mark = "[Cmd]" },
            cmdline_history = { mark = "[Hist]" },
        },

        filterParams = {
            matcher_fuzzy = {
                splitMode = 'word'
            },
        },

        sourceParams = {
            lsp = {
                snippetEngine = fn["denops#callback#register"](function(body)
                    return luasnip.lsp_expand(body)
                end),
                enableResolveItem = true,
                enableAdditionalTextEdit = true,
                confirmBehavior = "replace",
            },
            file = {
                mode = 'unix',
            }
        },

        cmdlineSources = {
            [":"] = { "cmdline", "cmdline_history", "file" },
            ["/"] = { "around" },
            ["?"] = { "around" },
        },
    })

    local ft_list = { "lua", "python", "go", "cpp", "c", "java", "kotlin", "html", "javascript", "typescript" }
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft_list,
        callback = function()
            fn["ddc#custom#patch_buffer"]({
                sources = { "lsp", "rg", "around", "file" },
            })
        end,
    })

    fn["ddc#enable"]()
    fn["ddc#enable_cmdline_completion"]()
end

return M
