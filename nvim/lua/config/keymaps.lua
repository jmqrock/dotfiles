-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "x" }, "cp", '"+y', { nowait = true, noremap = true, desc = "copy selected to system clipboard" })

vim.keymap.set({ "n" }, "gl", vim.diagnostic.open_float, { nowait = true, desc = "To show diagnostic info" })

vim.keymap.set(
  { "n", "x" },
  "<leader>bn",
  ":let @+=expand('%:t')<CR>",
  { nowait = true, desc = "copy the filename opened by current buf" }
)

vim.keymap.set(
  { "n", "x" },
  "<leader>bc",
  ":let @+=expand('%')<CR>",
  { nowait = true, desc = "copy the relative path opened by current buf" }
)

vim.keymap.set(
  { "n", "x" },
  "<leader>bC",
  "::let @+=expand('%:p')<CR>",
  { nowait = true, desc = "copy the full path opened by current buf" }
)
