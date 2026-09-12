vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.md', '*.typ'},
  command = 'setlocal wrap'
})

local opt = vim.opt -- for conciseness

-- line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4       -- 4 spaces for tabs
opt.shiftwidth = 4    -- 4 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping
opt.breakindent = true    -- useful for wrapped Markdown/Typst buffers
opt.virtualedit = "block" -- rectangular edits past end-of-line

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- undo
opt.undofile = true       -- strongest recommendation: persistent undo

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitkeep = "screen"  -- reduces jumpiness when opening splits

-- turn off swapfile
opt.swapfile = false
