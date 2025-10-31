local M = {}

function M.setup(opts)
    local config = vim.tbl_deep_extend("force", opts,
                                       {settings = {nodePath = ""}})
    vim.lsp.config("pyright", config)
end

return M
