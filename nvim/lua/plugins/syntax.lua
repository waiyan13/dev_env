return {
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.config")

			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
				sync_install = false,
			})
		end,
	},
}
