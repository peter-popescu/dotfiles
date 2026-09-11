return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    columns = { "icon", "size" },

    buf_options = {
      buflisted = true,
      bufhidden = "",
    },

    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = { enabled = false },
    watch_for_changes = true,

    keymaps = {
      ["l"] = "actions.select",
      ["h"] = { "actions.parent", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      ["<C-r>"] = "actions.refresh",
      ["<C-\\>"] = { "actions.select", opts = { vertical = true } },
      ["<C-->"] = { "actions.select", opts = { horizontal = true } },
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },

    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        return name == ".DS_Store"
      end,
    },

    float = { border = "rounded" },
    confirmation = { border = "rounded" },
    progress = { border = "rounded" },
    ssh = { border = "rounded" },
    keymaps_help = { border = "rounded" },
  },
  -- config = function(_, opts)
  --   require("oil").setup(opts)
  --
  --   local group = vim.api.nvim_create_augroup("OilPreview", { clear = true })
  --   vim.api.nvim_create_autocmd("User", {
  --     group = group,
  --     pattern = "OilEnter",
  --     callback = function(args)
  --       local bufnr = args.data.buf
  --       vim.schedule(function()
  --         if not vim.api.nvim_buf_is_valid(bufnr) then
  --           return
  --         end
  --
  --         local win = vim.fn.bufwinid(bufnr)
  --         if win == -1 or vim.w[win].oil_preview then
  --           return
  --         end
  --
  --         vim.api.nvim_win_call(win, function()
  --           require("oil").open_preview()
  --         end)
  --       end)
  --     end,
  --   })
  -- end,
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      desc = "Open Oil in current directory",
    },
    {
      "_",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      desc = "Open Oil in working directory",
    },
  },
}
