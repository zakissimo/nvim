return {
    {
        "nvim-lua/plenary.nvim",
    },

    -- {
    --     "willothy/flatten.nvim",
    --     config = true,
    --     lazy = false,
    --     priority = 1001,
    -- },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
    },

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
}
