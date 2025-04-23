vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 300, -- Set highlight duration
		})
	end,
})

-- Disable auto-commenting on newline when press enter
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable auto-commenting on newlines",
	pattern = "*",
	group = vim.api.nvim_create_augroup("format_options", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})
