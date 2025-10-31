return {
    {
        "hedyhli/outline.nvim",
        cmd = {"Outline", "OutlineOpen"},
        keys = {{"<leader>o", "<cmd>Outline<CR>", desc = "Outline tags"}},
        config = true
    }, {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = {"NvimTreeToggle"},
        dependencies = {"nvim-tree/nvim-web-devicons"},
        keys = {{"<leader>n", ":NvimTreeToggle<cr>", desc = "Toggle nvim-tree"}},
        opts = {
            --[[ for floating window
            view = {
                float = {
                    enable = true,
                    open_win_config = function()
                        local HEIGHT_RATIO = 0.8
                        local WIDTH_RATIO = 0.5

                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

                        return {
                          border = "rounded",
                          relative = "editor",
                          row = center_y,
                          col = center_x,
                          width = window_w_int,
                          height = window_h_int,
                        }
                    end,
                },
            },
            --]]
        },
        config = function(_, opts) require("nvim-tree").setup(opts) end
    }, {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {"nvim-lua/plenary.nvim"},
        keys = {
            {
                "<leader>ff",
                "<cmd>Telescope find_files<cr>",
                desc = "Search for files"
            },
            {
                "<leader>fg",
                "<cmd>Telescope live_grep<cr>",
                desc = "Search as you type"
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<cr>",
                desc = "List open buffers"
            }, {
                "<leader>fh",
                "<cmd>Telescope help_tags<cr>",
                desc = "List available help tags"
            }
        },
        config = true
    }
}
