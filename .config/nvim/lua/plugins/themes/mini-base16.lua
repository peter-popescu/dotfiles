-- Optional: mini.base16 provides automatic colorscheme support for all mini plugins
-- Comment out the dracula theme above and uncomment this to use mini.base16 instead
-- Benefits: All mini plugins get proper highlighting out of the box

return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    -- Only load if you want to use mini.base16 as colorscheme
    cond = false,
    config = function()
      require("mini.base16").setup({
        palette = nil,
        use_cterm = true,
      })
      vim.cmd.colorscheme("mini-darkblue")
    end,
  },
}
