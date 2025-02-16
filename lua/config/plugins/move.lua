return {
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },
  {
    "zakissimo/hooked.nvim",
    lazy = false,
    config = function()
      require("hooked").setup({
        prefix = "",
        suffix = "󰷫",
      })
    end,
    dev = false,
    keys = {
      { "<leader>m", "<CMD>HookedToggle<CR>", { "n" } },
      { "<M-m>", "<CMD>HookedMark<CR>", { "n" } },
      { "<M-u>", "<CMD>HookedPull 1<CR>", { "n" } },
      { "<M-i>", "<CMD>HookedPull 2<CR>", { "n" } },
      { "<M-o>", "<CMD>HookedPull 3<CR>", { "n" } },
      { "<M-p>", "<CMD>HookedPull 4<CR>", { "n" } },
    },
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        float = {
          padding = 10,
          win_options = {
            winblend = 0,
          },
        },
      })
      vim.keymap.set("n", "-", require("oil").open)
      vim.keymap.set("n", "<leader>n", require("oil").toggle_float)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "ivy",
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-L" },
          },
          git_files = {
            theme = "ivy",
          },
          live_grep = {
            theme = "ivy",
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")
      require("config.telescope.multigrep").setup(require("telescope.themes").get_ivy())

      vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<leader>g", require("telescope.builtin").git_files)
      vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags)
    end,
  },
}
