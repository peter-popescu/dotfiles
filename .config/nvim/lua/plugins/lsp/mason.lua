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
      -- Installation and activation are deliberately separate. See lspconfig.lua.
      automatic_enable = false,
      ensure_installed = {
        "asm_lsp",
        "clangd",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "jsonls",
        "lua_ls",
        "markdown_oxide",
        "ty",
        "rust_analyzer",
        "tinymist",
        "tombi",
        "vtsls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "clang-format",
        "cpplint",
        "golangci-lint",
        "prettierd",
        "prettypst",
        "ruff",
        "shfmt",
        "stylua",
      },
    })
  end,
}
