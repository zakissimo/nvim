return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        modules = {},
        sync_install = false,
        ignore_install = {},
        auto_install = true,

        ensure_installed = { "c", "cpp", "rust", "markdown", "lua", "vim", "vimdoc", "query" },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
