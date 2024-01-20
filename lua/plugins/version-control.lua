return {
    {
        "NeogitOrg/neogit",
        config = function()
            require("neogit").setup()
        end,
        keys = {
            { "<Leader>gg", "<CMD>Neogit<CR>" },
        },
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        "mbbill/undotree",
        keys = {
            { "<Leader>uu", "<CMD>UndotreeToggle<CR>" },
        },
    },
}
