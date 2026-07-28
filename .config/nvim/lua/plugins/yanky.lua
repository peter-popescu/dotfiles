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
    keymap.set("n", "p", "<plug>(YankyPutAfter)", { noremap = true })
    keymap.set("n", "P", "<plug>(YankyPutBefore)", { noremap = true })
    keymap.set("x", "p", "<plug>(YankyPutAfter)", { noremap = true })
    keymap.set("x", "P", "<plug>(YankyPutBefore)", { noremap = true })
    keymap.set("n", "[y", "<plug>(YankyCycleForward)", { noremap = true })
    keymap.set("n", "]y", "<plug>(YankyCycleBackward)", { noremap = true })
  end,
}
