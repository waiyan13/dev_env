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
            local lsp = require("lspconfig")
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

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    -- jdtls
                    local jdtls = require("jdtls")
                    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
                    local root_dir = require("jdtls.setup").find_root(root_markers)
                    local home = "/home/ubuntu"
                    local jdtls_config = {
                        cmd = {
                            "java",
                            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                            "-Dosgi.bundles.defaultStartLevel=4",
                            "-Declipse.product=org.eclipse.jdt.ls.core.product",
                            "-Dlog.protocol=true",
                            "-Dlog.level=ALL",
                            "-Xms1g",
                            "--add-modules=ALL-SYSTEM",
                            "--add-opens", "java.base/java.util=ALL-UNNAMED",
                            "--add-opens", "java.base/java.lang=ALL-UNNAMED",

                            "-javaagent:" .. home .. "/.local/share/lombok.jar",
                            "-Xbootclasspath/a:" .. home .. "/.local/share/lombok.jar",

                            "-jar", home .. "/.local/share/eclipse/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251014-1222.jar",
                            "-configuration", home .. "/.local/share/eclipse/jdtls/config_linux",
                            "-data", home .. "/.local/share/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
                        },
                        root_dir = root_dir,
                        capabilities = capabilities,
                        on_attach = on_attach,
                    }
                    jdtls.start_or_attach(jdtls_config)
                end,
            })

            --[[
            lsp.gopls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            --]]

            --[[
            lsp.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            extraPaths = { "" },
                        },
                        pythonPath = "",
                    },
                },
            })
            --]]

            --[[
            lsp.cssls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lsp.ts_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lsp.eslint.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    nodePath = "",
                },
            })

            lsp.biome.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            --]]

            --[[
            lsp.intelephense.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            --]]
        end,
    },
    {
        "onsails/lspkind.nvim",
        event = { "InsertEnter" },
    },
    --[[
    {
        "ray-x/go.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },
    --]]
    {
        "ray-x/lsp_signature.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            bind = true,
            floating_window_off_x = 5, -- adjust float windows x position.
            floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
                local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
                local pumheight = vim.o.pumheight
                local winline = vim.fn.winline() -- line number in the window
                local winheight = vim.fn.winheight(0)

                -- window top
                if winline - 1 < pumheight then
                    return pumheight
                end

                -- window bottom
                if winheight - winline < pumheight then
                    return -pumheight
                end

                return 0
            end,
            handler_opts = {
                border = "rounded",
            },
        },
    },
}

