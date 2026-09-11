return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    },
    config = function()
      local opts = { silent = true, desc = "Open Typst preview" }
      vim.keymap.set("n", "<leader>pt", "<cmd>TypstPreview<cr>", opts)
    end,
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("image").setup({
        backend = "sixel",
        processor = "magick_cli",
        max_width = 100,
        max_height = 50,
        window_overlap_clear_enabled = false,
        integrations = {
          markdown = {
            enabled = true,
            sizing_strategy = "fit_window",
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
      local opts = { silent = true, desc = "Open Markdown preview" }
      vim.keymap.set("n", "<leader>pm", "<cmd>MarkdownPreviewToggle<cr>", opts)
    end,
    ft = { "markdown" },
  },
}
