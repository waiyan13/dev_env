return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mfussenegger/nvim-jdtls" },
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<space>e", "<cmd>lua vim.diagnostic.open_float()<cr>", silent = true },
            { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", silent = true },
            { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", silent = true },
            { "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", silent = true },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts)
            end

            local opts = {
                capabilities = capabilities,
                on_attach = on_attach
            }

            local servers_dir = vim.fn.stdpath("config") .. "lua/plugins/lsp/servers"
            local servers = {}
            for _, file in ipairs(vim.fn.readdir(servers_dir, [[v:val =~ '\.lua$']])) do
                local server_name = file:gsub("%.lua$", "")
                local ok, server = pcall(require, "plugins.lsp." .. server_name)

                if ok and type(server.setup) == "function" then
                    server.setup(opts)
                    if server_name ~= "jdtls" then
                        table.insert(servers, server_name)
                    end
                else
                    vim.notify("LSP config missing for " .. server_name, vim.log.levels.WARN )
                end
            end

            if #servers > 0 then
                vim.lsp.enable(servers)
            end
        end,
    },
}
