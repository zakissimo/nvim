return {
    {
        "NeogitOrg/neogit",
        config = function()
            require("neogit").setup()
            vim.keymap.set("n", "<Leader>gg", "<CMD>Neogit<CR>")
        end,
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<Leader>uu", "<CMD>UndotreeToggle<CR>")
        end,
    },
}
