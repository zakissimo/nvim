return {
    {
        "NeogitOrg/neogit",
        config = function()
            require("neogit").setup()
        end,
        keys = {
            { "<Leader>s", "<CMD>Neogit<CR>" },
        },
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<Leader>u", "<CMD>UndotreeToggle<CR>" },
        },
    },
}
