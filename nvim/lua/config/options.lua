-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.inccommand = "split"
vim.opt.clipboard = ""

vim.g.autoformat = false

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- for indent-blankline
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.laststatus = 3

-- from theme gruvbox
-- vim.g.gruvbox_italic = 1
-- vim.g.gruvbox_transparent_bg = 2
-- vim.lsp.set_log_level("debug")

-- for JavaScript formatting
vim.g.lazyvim_prettier_needs_config = true
