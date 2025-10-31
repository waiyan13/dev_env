local M = {}

function M.setup(opts)
    local config = vim.tbl_deep_extend("force", opts, {
        settings = {python = {analysis = {extraPaths = {""}}, pythonPath = ""}}
    })
    vim.lsp.config("pyright", config)
end

return M
