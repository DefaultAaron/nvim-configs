return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					separator = true,
					text_align = "center",
					highlight = "Special",
				},
			},
			diagnostics = "nvim_lsp",
			separator_style = { "", "" },
			modified_icon = "●",
			show_close_icon = false,
			show_buffer_close_icons = true,
		},
	},
}
