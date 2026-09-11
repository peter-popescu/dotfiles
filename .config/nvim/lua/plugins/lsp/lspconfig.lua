return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local python_env = require("core.python_env")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      -- disable virtual text for line diagnostics
      virtual_text = false,

      -- Change the Diagnostic symbols in the sign column (gutter)
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },

      -- Don't update diagnostics while in insert mode (reduces excessive checks)
      update_in_insert = false,
    })

    local function root_with_fallback(markers)
      return function(bufnr, on_dir)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local directory = vim.fs.dirname(name) or vim.uv.cwd()
        on_dir(vim.fs.root(bufnr, markers) or directory)
      end
    end

    -- Racket LSP (installed via raco, not Mason)
    vim.lsp.config("racket_langserver", {
      cmd = { "racket", "--lib", "racket-langserver" },
      filetypes = { "racket", "scheme" },
      root_dir = root_with_fallback({ ".git" }),
    })

    vim.lsp.config("tinymist", {
      settings = {
        exportPdf = "onType",
        semanticTokens = "disable",
      },
    })

    vim.lsp.config("cooklang", {
      cmd = { "cook", "lsp" },
      filetypes = { "cook" },
      root_dir = root_with_fallback({ "config", ".git" }),
      settings = {},
    })

    vim.lsp.config("pyright", {
      root_markers = {
        "pyrightconfig.json",
        "pyproject.toml",
        "pixi.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
      },
      before_init = function(_, config)
        python_env.apply_to_pyright_config(config)
      end,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    vim.lsp.config("vtsls", {
      settings = {
        typescript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
        javascript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.api.nvim_create_user_command("PyrightPickEnv", function()
      python_env.pick(vim.api.nvim_get_current_buf())
    end, { desc = "Choose the Pyright interpreter for this workspace", force = true })

    vim.api.nvim_create_user_command("PyrightClearEnv", function()
      python_env.clear(vim.api.nvim_get_current_buf())
    end, { desc = "Clear the saved Pyright interpreter for this workspace", force = true })

    for _, server in ipairs({
      "asm_lsp",
      "clangd",
      "eslint",
      "golangci_lint_ls",
      "gopls",
      "jsonls",
      "lua_ls",
      "markdown_oxide",
      "pyright",
      "racket_langserver",
      "rust_analyzer",
      "tinymist",
      "tombi",
      "vtsls",
      "cooklang",
    }) do
      vim.lsp.enable(server)
    end
  end,
}
