return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui" },
		event = { "BufReadPre" },
		keys = {
			{ "<leader>dc", '<cmd>lua require("dap").continue()<cr>' },
			{ "<leader>dv", '<cmd>lua require("dap").step_over()<cr>' },
			{ "<leader>di", '<cmd>lua require("dap").step_into()<cr>' },
			{ "<leader>do", '<cmd>lua require("dap").step_out()<cr>' },
			{ "<leader>dt", '<cmd>lua require("dap").toggle_breakpoint()<cr>' },
			{ "<leader>db", '<cmd>lua require("dap").set_breakpoint()<cr>' },
			{
				"<leader>dl",
				'<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>',
			},
			{ "<leader>dp", '<cmd>lua require("dap").repl.open()<cr>' },
			{ "<leader>dr", '<cmd>lua require("dap").run_last()<cr>' },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			--[[
            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}"
                },
                -- works with go.mod packages and sub packages 
                {
                    type = "delve",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}"
                }
            }
            --]]

			--[[
            require("dap-python").setup()
            
            table.insert(dap.configurations.python, {
                type = "python",
                request = "launch",
                name = "",
                module = "",
                args = {},
                cwd = "",
            })
            --]]

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	--[[
    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        opts = {
            include_configs = true,
            console = "internalConsole",
        },
        config = function(_, opts)
            local python = require("dap-python")

            python.setup("", opts)
            python.test_runner = "pytest"
        end
    },
    --]]
	{ "rcarriga/nvim-dap-ui" },
}
