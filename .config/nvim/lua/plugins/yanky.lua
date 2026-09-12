return {
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup({
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      ring = {
        history_length = 100,
        storage = "shada",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky-rings.db",
        sync_with_numbered_registers = true,
        ignore_registers = { "_" },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    })

    -- Keymaps for yanky
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    opts.desc = "Put after"
    keymap.set({"n", "x"}, "p", "<plug>(YankyPutAfter)", opts)
    opts.desc = "Put before"
    keymap.set({"n", "x"}, "P", "<plug>(YankyPutBefore)", opts)
    opts.desc = "Cycle yank forward"
    keymap.set("n", "[y", "<plug>(YankyCycleForward)", opts)
    opts.desc = "Cycle yank backward"
    keymap.set("n", "]y", "<plug>(YankyCycleBackward)", opts)

    opts = { silent = true }
    opts.desc = "Copy to system clipboard"
    keymap.set({ "n", "x" }, "gy", '"+y', opts)
    opts.desc = "Paste from system clipboard"
    keymap.set({ "n", "x" }, "gp", '"+p', opts)
    opts.desc = "Paste before from system clipboard"
    keymap.set({ "n", "x" }, "gP", '"+P', opts)
  end,
}
