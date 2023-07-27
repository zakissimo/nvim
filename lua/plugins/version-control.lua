return {
    {
        "lewis6991/gitsigns.nvim",
    },
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

    -- {
    --     "sourcegraph/sg.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --
    --     build = "nvim -l build/init.lua",
    -- },
    {
        "mbbill/undotree",
        on_attach = function()
            vim.keymap.set("n", "<Leader>uu", "<CMD>UndotreeToggle<CR>")
        end,
    },
}
