-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- local function override_lsp_keymaps()
--   local keys = require("lazyvim.plugins.lsp.keymaps").get()
--
--   -- for _, keymap in ipairs(keymaps or {}) do
--   --   keys[#keys + 1] = keymap
--   -- end
-- end
--
-- override_lsp_keymaps()

-- vim.keymap.set({ "n", "x" }, "cp", '"+y', { nowait = true, noremap = true, desc = "copy selected to system clipboard" })

vim.keymap.set({ "n" }, "gl", vim.diagnostic.open_float, { nowait = true, desc = "To show diagnostic info" })

vim.keymap.set({ "n" }, "<leader>fG", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

