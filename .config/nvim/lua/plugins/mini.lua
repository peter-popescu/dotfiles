return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      local keymap = vim.keymap -- for conciseness
      local opts = { silent = true }

      -- status bar
      require("mini.statusline").setup()

      -- info on left column
      require("mini.statuscolumn").setup()

      -- highlight word under cursor
      require("mini.cursorword").setup()

      -- surround actions
      require("mini.surround").setup()

      -- extend a/i text objects
      require("mini.ai").setup()

      -- start screen
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
          -- starter.gen_hook.indexing("all", { "Builtin actions" }),
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

      -- indent guides and scope visualization
      require("mini.indentscope").setup({ symbol = "┊" })

      -- comment lines
      require("mini.comment").setup()

      -- highlight and trim whitespace
      require("mini.trailspace").setup()
      opts.desc = "Delete trailing whitespace"
      keymap.set("n", "<leader>kx", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

      -- move selection
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode.
          left = "<Char-0xAA>",
          down = "<Char-0xAB>",
          up = "<Char-0xAC>",
          right = "<Char-0xAD>",

          -- Move current line in Normal mode
          line_left = "<Char-0xAA>",
          line_down = "<Char-0xAB>",
          line_up = "<Char-0xAC>",
          line_right = "<Char-0xAD>",
        },
      })

      -- split, justify, merge selections
      require("mini.align").setup()

      -- text edit ops
      require("mini.operators").setup()

      -- split and join args
      require("mini.splitjoin").setup()

      -- jump!
      require("mini.jump").setup()
      require("mini.jump2d").setup()

      -- more bracket movements
      require("mini.bracketed").setup({
        yank = { suffix = "", options = {} },
        diagnostic = { suffix = "", options = {} },
      })

      -- cmd line completions
      require("mini.cmdline").setup()

      -- keep windows after buffer close
      local bufremove = require("mini.bufremove")
      bufremove.setup()
      keymap.set("n", "<leader>bx", function()
        bufremove.delete(0, false)
      end, { desc = "Delete buffer, preserve windows" })

      -- option toggle and relnum in visual
      require("mini.basics").setup({
        options = { basic = false, extra_ui = false },
        mappings = {
          basic = false,
          option_toggle_prefix = [[\]],
          windows = false,
          move_with_alt = false,
        },
        autocommands = {
          basic = false, -- Yanky already highlights yanks
          relnum_in_visual_mode = true,
        },
        silent = true,
      })
    end,
  },
}
