return {
    {
        "sourcegraph/sg.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
        },
        keys = {
            { "<leader>co", "<cmd>CodyToggle<cr>" },
        },
        config = function()
            require("sg").setup()
        end
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
