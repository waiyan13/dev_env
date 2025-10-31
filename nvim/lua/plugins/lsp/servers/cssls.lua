local M = {}

function M.setup(opts)
    vim.lsp.config("cssls", opts)
end

return M
