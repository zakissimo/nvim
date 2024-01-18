return {
    {
        "sourcegraph/sg.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
        },
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
