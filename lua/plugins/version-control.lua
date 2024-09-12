return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
        },
        config = true,
        keys = {
            { "<Leader>s", "<CMD>Neogit<CR>" },
        },
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
