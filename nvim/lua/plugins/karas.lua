return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  { "numToStr/Comment.nvim" },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = 'compact'
    }
  },
}
