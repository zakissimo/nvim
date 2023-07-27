return {
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
        lazy = true,
        dependencies = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    }
}
