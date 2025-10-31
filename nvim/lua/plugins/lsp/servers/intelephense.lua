local M = {}

function M.setup(opts)
    vim.lsp.config("intelephense", opts)
end

return M
