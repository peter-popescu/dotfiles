return {
  {
    "maxmx03/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      ---@type dracula
      local dracula = require("dracula")

      dracula.setup({
        styles = {
          Type = {},
          Function = {},
          Parameter = {},
          Property = {},
          Comment = {},
          String = {},
          Keyword = {},
          Identifier = {},
          Constant = {},
        },
        transparent = true,
        on_colors = function(colors, color)
          ---@type dracula.palette
          return {
            -- override or create new colors
            mycolor = "#ffffff",
            -- mycolor = 0xffffff,
          }
        end,
        on_highlights = function(colors, color)
          ---@type dracula.highlights
          return {
            ---@type vim.api.keyset.highlight
            Normal = { fg = colors.mycolor },
          }
        end,
        plugins = {
          ["nvim-treesitter"] = true,
          ["nvim-lspconfig"] = true,
          ["nvim-cmp"] = true,
          ["nvim-tree.lua"] = true,
          ["indent-blankline.nvim"] = true,
          ["which-key.nvim"] = true,
          ["dashboard-nvim"] = true,
          ["gitsigns.nvim"] = true,
          ["todo-comments.nvim"] = true,
          ["lazy.nvim"] = true,
          ["telescope.nvim"] = true,
          ["noice.nvim"] = true,
          ["mini.statusline"] = true,
          ["mini.starter"] = true,
          ["mini.cursorword"] = true,
          ["mini.indentscope"] = true,
          ["mini.trailspace"] = true,
          ["mini.jump"] = true,
          ["mini.jump2d"] = true,
          ["mini.files"] = true,
        },
      })
      -- vim.cmd.colorscheme("dracula")
      vim.cmd.colorscheme("dracula-soft")
    end,
  },
}
