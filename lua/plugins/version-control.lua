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
        "mbbill/undotree",
        keys = {
            { "<Leader>u", "<CMD>UndotreeToggle<CR>" },
        },
    },
}
