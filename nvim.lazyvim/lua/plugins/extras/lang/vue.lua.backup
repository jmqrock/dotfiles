-- vue
-- enable take over mode, disable tsserver
-- TODO: should improve for monorepo
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      -- get path from current buffer
      local vue_language_server_path = require("mason-registry").get_package("vue-language-server"):get_install_path()
      local ts_plugin_path = vue_language_server_path .. "/node_modules/@vue/typescript-plugin"
      -- local current_path = vim.fn.expand("%:p:h")
      -- local util = require("lspconfig.util")
      -- local project_root = util.find_node_modules_ancestor(current_path)
      --
      -- local vue_path = util.path.join(project_root, "node_modules", "vue")
      -- local is_vue = vim.fn.isdirectory(vue_path) == 1
      opts.servers.tsserver = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = ts_plugin_path,
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        single_file_support = false,
        filetypes = {
          "vue",
          "javascript",
          "javascript.jsx",
          "typescript",
          "typescript.tsx",
          "javascriptreact",
          "typescriptreact",
          "json",
        },
      }
      return opts
    end,
    keys = {
      { "gK", false },
      { "gi", "gI", remap = true, desc = "Goto Implement" },
      { "<c-k>", vim.lsp.buf.signature_help, desc = "Signature help" },
      { "<c-j>", "]d", remap = true },
    },
  },
}
