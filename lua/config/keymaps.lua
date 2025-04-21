-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set <space>pv to go to the pervious dir
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Use `jk` to quit current mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("v", "jk", "<ESC>")
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Set `<space>nh` to remove the highlight in normal mode
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Remove Highlight" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Create new window
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")

--- Move focus:lua local ok, _ = pcall(vim.api.nvim_get_augroup_id, "kickstart-highlight-yank"); print(ok)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move line(s)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Set git key maps
vim.keymap.set("n", "<leader>ga", ":!git add .<CR>", { desc = "Git add all" })
vim.keymap.set("n", "<leader>gp", ":!git push<CR>", { desc = "Git push" })

-- Open terminal
vim.api.nvim_create_user_command("TermBottom", function(ops)
    vim.cmd("botright 10split")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end, { nargs = 0})

vim.keymap.set("n", "<leader>t", ":TermBottom<CR>")
