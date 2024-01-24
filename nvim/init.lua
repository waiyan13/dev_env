vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = "'"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	checker = { enabled = true },
})

vim.o.background = "dark"
vim.g.material_style = "oceanic"
vim.cmd([[colorscheme material]])

vim.opt.number = true
vim.opt.termguicolors = true
vim.wo.relativenumber = true

--[[
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !isort --profile black --combine-as true %")
            vim.cmd("silent !black --quiet %")
            vim.cmd("!ruff check --fix %")
            vim.cmd("edit")
        end,
    }
)
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = {"*.js", "*.jsx", "*.ts", "*.tsx"},
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !npx eslint --fix %")
            vim.cmd("silent !npx prettier --write %")
            vim.cmd("edit")
        end,
    }
)
--]]
