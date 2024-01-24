return {
    {
        "hedyhli/outline.nvim",
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Outline tags" },
        },
        config = true,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = { "NvimTreeToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<C-n>", ":NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
        },
        config = true,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Search for files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search as you type" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "List available help tags" },
        },
        config = true,
    },
}
