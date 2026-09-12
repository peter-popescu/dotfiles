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
