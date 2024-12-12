return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>s", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader>u", "<CMD>UndotreeToggle<CR>" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
}
