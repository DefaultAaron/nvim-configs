return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "lua", "python" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          additional_vim_regex_highlighting = false,
        })
    end
}
