-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- for pig syntax coloring
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.pig" },
  callback = function()
    local src_pig_syntax = "source " .. vim.fn.expand("~") .. "/.config/nvim/syntax/pig.vim"
    vim.cmd(src_pig_syntax)
  end,
})
