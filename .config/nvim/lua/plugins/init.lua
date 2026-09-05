return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  "tpope/vim-sleuth", -- set buffer options
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        merge_duplicates = true,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    notify = {
      merge = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
  },
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {
      -- open_cmd = "qutebrowser %s",
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    }, -- lazy.nvim will implicitly calls `setup {}`
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end,
  },
  -- {
  --   {
  --     "quarto-dev/quarto-nvim",
  --     dependencies = {
  --       "jmbuhr/otter.nvim",
  --       "nvim-treesitter/nvim-treesitter",
  --     },
  --   },
  -- },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("image").setup({
        backend = "sixel",
        processor = "magick_cli",
        max_width = 100,
        max_height = 50,
        window_overlap_clear_enabled = false,
        integrations = {
          markdown = {
            enabled = true,
            sizing_strategy = "fit_window",
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
      })
    end,
  },
  {
    "Olical/conjure",
    ft = { "racket", "scheme" },
    lazy = true,
    init = function() end,
  },
  {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {
      -- Match your cursor color to prevent jarring color changes
      -- Options: hex color "#rrggbb", highlight group name, or "none" for text color
      cursor_color = "#ffffff",
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
    },
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "pteroctopus/faster.nvim" },
  { "luizribeiro/vim-cooklang" },
}
