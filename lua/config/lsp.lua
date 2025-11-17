-- lua/config/lsp.lua
local M = {}

function M.setup()
    vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        float = { border = "rounded" },
        severity_sort = true,
        signs = true,
    })
end

return M
