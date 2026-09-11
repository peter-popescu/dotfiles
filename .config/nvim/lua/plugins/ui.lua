return {
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
      --   `nvim-notify` is only needed if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    notify = {
      merge = true,
    },
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
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
  },
}
