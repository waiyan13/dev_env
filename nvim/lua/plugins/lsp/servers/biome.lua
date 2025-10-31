local M = {}

function M.setup(opts)
    vim.lsp.config("biome", opts)
end

return M
