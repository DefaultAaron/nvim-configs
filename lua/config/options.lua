-- Display the line number and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Setup indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Save undo history
-- vim.opt.undofile = true

-- Enable mouse
vim.opt.mouse = "a"

-- Highlight current line
vim.opt.cursorline = true

-- Hide the mode
vim.opt.showmode = false

-- Sync clipboard
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitution commands
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Confirm quit with unsaved changes
vim.opt.confirm = true

-- Use full RGB colors instead of 256-color palette
vim.opt.termguicolors = true

-- Disable auto-commenting on Enter
vim.opt.formatoptions:remove({ "r" })
