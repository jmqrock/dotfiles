-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local src_pig_syntax = "source" .. os.getenv("HOME") .. "/.config/nvim/syntax/pig.vim"
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.pig" },
  command = src_pig_syntax,
})
