return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>xx", '<cmd>lua require("trouble").toggle()<cr>' },
			{ "<leader>xw", '<cmd>lua require("trouble").toggle("workspace_diagnostics")<cr>' },
			{ "<leader>xd", '<cmd>lua require("trouble").toggle("document_diagnostics")<cr>' },
			{ "<leader>xq", '<cmd>lua require("trouble").toggle("quickfix")<cr>' },
			{ "<leader>xl", '<cmd>lua require("trouble").toggle("loclist")<cr>' },
			{ "gR", '<cmd>lua require("trouble").toggle("lsp_references")<cr>' },
		},
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = {
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			},
		},
		config = function(_, opts)
			local ibl = require("ibl")
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			ibl.setup(opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		opts = function()
			local colors = {
				blue = "#80a0ff",
				cyan = "#79dac8",
				black = "#080808",
				white = "#c6c6c6",
				red = "#ff5189",
				violet = "#d183e8",
				grey = "#303030",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.black, bg = colors.black },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.black, bg = colors.black },
				},
			}

			return {
				options = {
					theme = bubbles_theme,
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = { "branch", "filename", "diff", "diagnostics" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "encoding", "filetype", "progress" },
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = {},
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
