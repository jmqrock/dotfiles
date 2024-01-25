-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.inccommand = "split"
vim.opt.clipboard = ""

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.copilot_proxy = "127.0.0.1:8234"

vim.g.autoformat = false

-- for indent-blankline
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
