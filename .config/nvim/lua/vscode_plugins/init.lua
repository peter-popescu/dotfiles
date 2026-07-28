return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = {} },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    cond = not not vim.g.vscode,
    opts = {},
  },
}
