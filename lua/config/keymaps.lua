-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set <space>pv to go to the pervious dir
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Use `jk` to quit current mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("v", "jk", "<ESC>")
vim.keymap.set("t", "jk", function()
  -- Exit terminal mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  
  -- Close the terminal window
  vim.cmd("q")  -- Use :q to quit the terminal buffer
end, { desc = "Exit terminal mode and close window" })

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

-- Open terminal
vim.api.nvim_create_user_command("TermBottom", function(ops)
    vim.cmd("botright 10split")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end, { nargs = 0})

vim.keymap.set("n", "<leader>t", ":TermBottom<CR>")

-- Git push in terminal
vim.api.nvim_create_user_command("GitPush", function()
  local term_buf = nil

  -- Look for an existing terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
      term_buf = buf
      break
    end
  end

  -- If no terminal found, open one via TermBottom
  if not term_buf then
    vim.cmd("TermBottom")
    term_buf = vim.api.nvim_get_current_buf()
  end

  -- Get terminal job ID
  local job_id = vim.b[term_buf].terminal_job_id
  if job_id then
    vim.fn.chansend(job_id, "git push\n")
  else
    print("❌ Could not get terminal job ID.")
  end
end, {})

-- Set git key maps
vim.keymap.set("n", "<leader>ga", ":!git add .<CR>", { desc = "Git add all" })
vim.keymap.set("n", "<leader>gc", function()
  vim.ui.input({ prompt = "Commit message: " }, function(input)
    if not input or input == "" then
      print("❌ Aborted: No commit message.")
      return
    end

    local msg = input:gsub('"', '\\"')
    vim.cmd("!git commit -m \"" .. msg .. "\"")
  end)
end, { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", ":GitPush<CR>", { desc = "Git push" })
