return {
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Outline tags" } },
		config = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "<leader>n", ":NvimTreeToggle<cr>", desc = "Toggle nvim-tree" } },
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
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			-- this will download prebuild binary or try to use existing rustup toolchain to build from source
			-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
			require("fff.download").download_or_build_binary()
		end,
		-- if you are using nixos
		-- build = "nix run .#release",
		opts = { -- (optional)
			debug = {
				enabled = true, -- we expect your collaboration at least during the beta
				show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
			},
		},
		-- No need to lazy-load with lazy.nvim.
		-- This plugin initializes itself lazily.
		lazy = false,
		keys = {
			{
				"ff", -- try it if you didn't it is a banger keybinding for a picker
				function()
					require("fff").find_files()
				end,
				desc = "FFFind files",
			},
			{
				"fg",
				function()
					require("fff").live_grep()
				end,
				desc = "LiFFFe grep",
			},
			{
				"fz",
				function()
					require("fff").live_grep({
						grep = {
							modes = { "fuzzy", "plain" },
						},
					})
				end,
				desc = "Live fffuzy grep",
			},
			{
				"fc",
				function()
					require("fff").live_grep({ query = vim.fn.expand("<cword>") })
				end,
				desc = "Search current word",
			},
		},
	},
}
