-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- save and quit
keymap.set("n", "<leader>ww", ":w<CR>", { silent = true, desc = "Save Changes to Buffer" })
keymap.set("n", "<leader>qq", ":qa<CR>", { silent = true, desc = "Quit Nvim" })

-- clear search highlights
keymap.set("n", "<Esc>", function()
  vim.cmd.nohlsearch()
  require("notify").dismiss()
  vim.cmd.echo()
end, { silent = true })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- window managent
keymap.set("n", "<leader>s\\", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tc", "<cmd>tabnew<CR>", { desc = "Create new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close current buffer" }) -- close current tab
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Go to next buffer" }) --  go to next buffer
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Go to previous buffer" }) --  go to previous buffer
