return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                },
                scope = { enabled = false },
            })
        end,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    {
        "MunifTanjim/nui.nvim",
    },
    {
        "rcarriga/nvim-notify",
    },
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                relative = "editor",
                win_options = {
                    winblend = 0,
                },
                select = {
                    win_options = {
                        winblend = 0,
                    },
                },
            },
        },
    },
    {
        "alvarosevilla95/luatab.nvim",
        config = function()
            require("luatab").setup({})
        end,
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
    },
}
