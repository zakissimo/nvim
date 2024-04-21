return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    {
        "sbulav/nredir.nvim",
    },
    {
        "willothy/flatten.nvim",
        config = true,
        lazy = false,
        priority = 1001,
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
    },

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
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup()
        end,
    },
    {
        "zakissimo/smoji.nvim",
        config = function()
            require("smoji")
        end,
        keys = {
            { "<Leader><Leader>e", "<CMD>Smoji<CR>" },
        },
    },
    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true,
            })
        end,
        keys = {
            { "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>" },
        },
    },

    {
        "zakissimo/run.nvim",
        dev = false,
        keys = {
            { "<Leader>cc", "<CMD>lua require'run'.cmd()<CR>" },
        },
    },
}
