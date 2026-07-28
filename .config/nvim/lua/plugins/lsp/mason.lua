return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      automatic_installation = true,
      ensure_installed = {
        "vtsls", -- typescript/javascript LSP (replaces tsserver)
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "clangd",
        "asm_lsp",
        -- "ltex",
        "markdown_oxide",
        "gopls",
        "tinymist",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- "vtsls", -- typescript/javascript LSP
        "eslint_d", -- javascript/typescript linter & formatter
        "prettierd", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        -- "clang-format", -- c/c++ formatter
        "pylint", -- python linter
        "cpplint", -- c/c++ linter
        "golangci_lint_ls", -- go linter
      },
    })
  end,
}
