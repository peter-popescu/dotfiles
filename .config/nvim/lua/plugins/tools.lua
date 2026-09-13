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
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    enabled = vim.env.NVIM_APPNAME ~= "remote-nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    keys = {
      { "<leader>rr", "<cmd>RemoteStart<CR>", desc = "Start remote Neovim" },
      { "<leader>ri", "<cmd>RemoteInfo<CR>", desc = "Show remote Neovim status" },
    },
    opts = {
      remote = {
        -- remote-nvim owns this isolated config/data/state tree on the host.
        -- Keep the default config-only copy: local Lazy/Mason binaries are
        -- macOS artifacts and should not be copied to Linux.
        app_name = "remote-nvim",
      },
      client_callback = function(port, _)
        local remote_ui_command = ("nvim --server localhost:%s --remote-ui"):format(port)

        -- A dedicated tmux window avoids nesting a second Neovim UI in a
        -- float. Fall back to the plugin's normal float outside tmux or if
        -- tmux cannot create the window.
        if vim.env.TMUX and vim.fn.exepath("tmux") ~= "" then
          vim.system({ "tmux", "new-window", "-n", "remote-nvim", remote_ui_command }, {}, function(result)
            if result.code ~= 0 then
              vim.schedule(function()
                require("remote-nvim.ui").float_term(remote_ui_command)
              end)
            end
          end)
          return
        end

        require("remote-nvim.ui").float_term(remote_ui_command)
      end,
    },
  },
}
