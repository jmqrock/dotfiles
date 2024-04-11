vim.lsp.set_log_level(vim.log.levels.ERROR)

return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "VeryLazy" },
    opts = {
      diagnostics = {
        virtual_text = {
          source = false,
        },
      },
    },
  },

  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      log_level = vim.log.levels.ERROR,
      ensure_installed = {
        "stylua",
        "vue-language-server",
        "bash-language-server",
        "clang-format",
        "clangd",
        "css-lsp",
        "deno",
        "html-lsp",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "pyright",
        "ruff-lsp",
        "rust-analyzer",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
        "typescript-language-server",
        "shellcheck",
        "shfmt",
        "prettier",
      },
    },
  },
  {
    "tamago324/nlsp-settings.nvim",
    cmd = "LspSettings",
    opts = {},
  },

  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },

  { import = "plugins.extras.lang.cspell" },
  { import = "plugins.extras.lang.vue" },
  { import = "plugins.extras.linting.eslint" },
}
