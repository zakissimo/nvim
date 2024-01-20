return {
    {
        "sourcegraph/sg.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
        },
        keys = {
            { "<leader>co", "<cmd>CodyToggle<cr>" }
        }
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
