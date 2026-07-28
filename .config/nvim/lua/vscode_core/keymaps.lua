local keymap = vim.keymap -- for conciseness

-- set leader key to space
keymap.set("n", "<Space>", "")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
---------------------
-- General Keymaps -------------------

-- save and quit
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Changes to Buffer" })
keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit Nvim" })

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true, desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

