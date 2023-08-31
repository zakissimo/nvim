return {
    {
        "sourcegraph/sg.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },

        build = "nvim -l build/init.lua",
        config = function()
            vim.keymap.set({ "t", "n" }, "<Leader>co", "<CMD>CodyToggle<CR>")
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    },
}
