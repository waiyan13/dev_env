local M = {}

function M.setup(opts)
    vim.lsp.config("ts_ls", opts)
end

return M
