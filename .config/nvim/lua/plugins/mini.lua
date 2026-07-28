return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      local keymap = vim.keymap -- for conciseness
      local opts = { silent = true }

      -- mini.statusline
      require("mini.statusline").setup()

      -- mini.cursorword
      require("mini.cursorword").setup()

      -- mini.surround - surround actions
      require("mini.surround").setup()

      -- mini.ai - extend a/i text objects
      require("mini.ai").setup()

      -- mini.starter - start screen
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        silent = true,
        items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(5, false),
          starter.sections.recent_files(5, true),
          starter.sections.telescope(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("all", { "Builtin actions" }),
          starter.gen_hook.padding(3, 2),
        },
        header = table.concat({
          "                                                     ",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
          "                                                     ",
        }, "\n"),
      })

      -- mini.indentscope - indent guides and scope visualization
      require("mini.indentscope").setup({ symbol = "┊" })

      -- mini.comment - comment lines
      require("mini.comment").setup()

      -- mini.trailspace - highlight and trim whitespace
      require("mini.trailspace").setup()
      opts.desc = "Delete trailing whitespace"
      keymap.set("n", "<leader>kx", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

      -- mini.move - move selection
      require("mini.move").setup()

      -- mini.operators - text edit ops
      require("mini.operators").setup()

      -- mini.splitjoin - split and join args
      require("mini.splitjoin").setup()

      -- mini.jump(2d) - jump!
      require("mini.jump").setup()
      require("mini.jump2d").setup()

      -- mini.files - file explorer/editor
      -- require("mini.files").setup({ windows = { preview = true } })
      -- opts.desc = "Open file explorer"
      -- keymap.set("n", "-", "<cmd>lua require('mini.files').open()<cr>", opts)
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "TelescopeFindPre",
      --   callback = function()
      --     if _G.MiniFiles then
      --       _G.MiniFiles.close()
      --     end
      --   end,
      -- })
    end,
  },
}
