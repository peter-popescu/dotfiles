if vim.g.vscode then
  -- VSCode
  require("vscode_core")
else
  -- Neovim
  require("core")
end

require("setup")
