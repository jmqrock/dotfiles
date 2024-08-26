-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "x" }, "cp", '"+y', { nowait = true, noremap = true, desc = "copy selected to system clipboard" })

vim.keymap.set({ "n" }, "gl", vim.diagnostic.open_float, { nowait = true, desc = "To show diagnostic info" })

vim.keymap.set({ "n" }, "<leader>fG", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

vim.keymap.set(
  { "n", "x" },
  "<leader>bn",
  "<cmd>let @+=expand('%:t')<CR>",
  { nowait = true, desc = "copy the filename opened by current buf" }
)

vim.keymap.set(
  { "n", "x" },
  "<leader>bc",
  "<cmd>let @+=expand('%')<CR>",
  { nowait = true, desc = "copy the relative path opened by current buf" }
)

vim.keymap.set(
  { "n", "x" },
  "<leader>bC",
  "<cmd>let @+=expand('%:p')<CR>",
  { nowait = true, desc = "copy the full path opened by current buf" }
)

vim.keymap.set(
  { "n", "x" },
  "<leader>tn",
  "<cmd>Telescope notify<CR>",
  { nowait = true, desc = "display a log of the history of notifications." }
)
