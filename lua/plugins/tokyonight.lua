return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup {
            styles = {
                -- Disable italics in comments
                comments = { italic = false }
            }
        }
        vim.cmd[[colorscheme tokyonight-night]]
    end
}
