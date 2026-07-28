return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  priority = 100,
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.config")
    local parser_config = require("nvim-treesitter.parsers")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "python",
        "rust",
        "java",
        "cpp",
        -- "go",
        "csv",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        -- "regex",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        -- "racket"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- add forge syntax highlighting
    vim.filetype.add({
      extension = {
        frg = function(path, bufnr)
          return "forge",
            function(bufnr)
              -- for https://neovim.io/doc/user/various.html#commenting
              vim.api.nvim_set_option_value("commentstring", "// %s", { buf = bufnr })
            end
        end,
      },
    })

    parser_config.forge = {
      install_info = {
        url = "~/.config/tree-sitter-forge", -- path to the cloned tree-sitter-forge
        files = { "src/parser.c" },
      },
      filetype = "frg",
    }
  end,
}
