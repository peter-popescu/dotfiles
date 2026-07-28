local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "common_plugins" },
  {
    import = "plugins",
    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    import = "vscode_plugins",
    cond = function()
      return vim.g.vscode
    end,
  },
  {
    import = "plugins.lsp",
    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    import = "plugins.themes.dracula",
    cond = function()
      return not vim.g.vscode
    end,
  },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
