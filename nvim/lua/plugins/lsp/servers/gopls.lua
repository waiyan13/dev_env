local M = {}

function M.setup(opts)
    vim.lsp.config("gopls", opts)
end

return M
