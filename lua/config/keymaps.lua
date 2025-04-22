-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set <space>pv to go to the pervious dir
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Use `jk` to quit current mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("v", "jk", "<ESC>")
vim.keymap.set("t", "jk", function()
  vim.cmd("stopinsert")
  vim.cmd("q")
end, { desc = "Exit and close terminal", noremap = true })

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

-- Display the terminal if exists else create
local function get_or_create_terminal()
  local term_buf = nil
  local term_win = nil

  -- Look for any existing terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      term_buf = buf
      -- Check if it's visible in a window
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          term_win = win
          break
        end
      end
      break
    end
  end

  -- Terminal exists and is visible
  if term_win then
    vim.api.nvim_set_current_win(term_win)
  -- Terminal exists but hidden
  elseif term_buf then
    vim.cmd("botright 10split")
    vim.api.nvim_set_current_buf(term_buf)
  -- No terminal at all — create new
  else
    vim.cmd("botright 10split")
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end

  vim.cmd("startinsert")
  return term_buf
end

-- Key map to get or create terminal
vim.keymap.set("n", "<leader>t", function()
  get_or_create_terminal()
end, { desc = "Open or reuse terminal at bottom" })

local function refresh_neotree_git_status_after_delay(term_buf, delay)
  local function is_git_done()
    local lines = vim.api.nvim_buf_get_lines(term_buf, -10, -1, false)
    for _, line in ipairs(lines) do
      if line:match("^%[.+%]")
        or line:match("%d+ file[s]? changed")
        or line:match("insertion")
        or line:match("deletion")
        or line:match("create mode")
        or line:match("delete mode")
        or line:match("rename ") then
        return true
      end
    end
    return false
  end

  local timer = vim.loop.new_timer()
  local attempts = 0
  timer:start(delay, 300, vim.schedule_wrap(function()
    attempts = attempts + 1
    if is_git_done() or attempts > 7 then -- Max ~2.1s
      timer:stop()
      timer:close()
      require("neo-tree.sources.git_status").refresh()
    end
  end))
end

-- Command to stage and commit the changes
vim.api.nvim_create_user_command("GitCommit", function()
  vim.ui.input({ prompt = "Commit message: " }, function(input)
    if not input or input == "" then
      print("❌ Aborted: No commit message.")
      return
    end

    local msg = input:gsub('"', '\\"')
    local term_buf = get_or_create_terminal()
    local job_id = vim.b[term_buf].terminal_job_id

    if job_id then
      vim.fn.chansend(job_id, "git add . && git commit -m \"" .. msg .. "\"\n")
      refresh_neotree_git_status_after_delay(term_buf, 300)
    else
      print("❌ Could not get terminal job ID.")
    end
  end)
end, { desc = "Add all and commit with a message" })

-- Command to push changes
vim.api.nvim_create_user_command("GitPush", function()
  local term_buf = get_or_create_terminal()
  local job_id = vim.b[term_buf].terminal_job_id

  if job_id then
    vim.fn.chansend(job_id, "git push\n")
  else
    print("❌ Could not get terminal job ID.")
  end
end, { desc = "Push using git in terminal" })

-- Set git key maps
vim.keymap.set("n", "<leader>gc", ":GitCommit<CR>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gp", ":GitPush<CR>", { desc = "Git push" })
