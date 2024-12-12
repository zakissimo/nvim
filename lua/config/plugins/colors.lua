return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
