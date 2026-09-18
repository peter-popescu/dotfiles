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
        -- In remote-nvim, reading +/* asks the terminal for OSC52 paste data.
        -- Keep system-clipboard yanks out of Yanky's history to avoid that read.
        ignore_registers = vim.env.NVIM_APPNAME == "remote-nvim" and { "_", "+", "*" } or { "_" },
      },
      system_clipboard = {
        -- OSC52 copy works through remote-nvim, but OSC52 clipboard reads do not.
        sync_with_ring = vim.env.NVIM_APPNAME ~= "remote-nvim",
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
    if vim.env.NVIM_APPNAME == "remote-nvim" then
      opts.desc = "Put after from Yanky ring"
      keymap.set({ "n", "x" }, "gp", "<plug>(YankyPutAfter)", opts)
      opts.desc = "Put before from Yanky ring"
      keymap.set({ "n", "x" }, "gP", "<plug>(YankyPutBefore)", opts)
    else
      opts.desc = "Paste from system clipboard"
      keymap.set({ "n", "x" }, "gp", '"+p', opts)
      opts.desc = "Paste before from system clipboard"
      keymap.set({ "n", "x" }, "gP", '"+P', opts)
    end
  end,
}
