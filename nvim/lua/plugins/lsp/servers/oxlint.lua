local M = {}

function M.setup(opts) vim.lsp.config("oxlint", opts) end

return M
