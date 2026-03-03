return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "lua",
        "python",
        "bash",
        "sh",
        "zsh",
        "gitcommit",
        "comment",
        "json",
        "yaml",
        "html",
        "css",
        "javascript",
        "typescript",
        "markdown",
      },
    },
  },
}
