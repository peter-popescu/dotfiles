return {

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end,
  },
  {
    "meznaric/key-analyzer.nvim",
    cmd = "KeyAnalyzer",
    opts = {},
    config = function()
      require("key-analyzer").setup()
      vim.keymap.set("n", "<leader>ka", "<cmd>KeyAnalyzer<cr>", { desc = "Toggle Key Analyzer" })
    end,
  },
  {
    "Kohei-Wada/yadm-git.nvim",
    lazy = false,
    config = function()
      require("yadm-git").setup()
    end,
  },
  {
    "Olical/conjure",
    ft = { "racket", "scheme" },
    lazy = true,
    init = function() end,
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
