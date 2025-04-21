-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            timeout = 300 -- Set highlight duration
        })
    end,
})

-- Disable auto-commenting on newline when press enter
vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable auto-commenting on newlines",
    pattern = "*",
    group = vim.api.nvim_create_augroup("format_options", { clear = true }),
    callback = function()
        vim.opt_local.formatoptions:remove({ "r" })
    end,
})

-- Remove terminal indent
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Close sign column for terminal",
    group = vim.api.nvim_create_augroup("terminal-options", { clear = true }),
    callback = function()
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})
