return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
    -- fill any relevant options here
    },
    config = function()
        require("neo-tree").setup({
            window = {
                width = 30
            },
            filesystem = {
                follow_current_file = {
                    enabled = true
                },
                hijack_netrw_behavior = "open_default",
            },
        })

        vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")
    end,
}
