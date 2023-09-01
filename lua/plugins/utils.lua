return {
    {
        "nvim-lua/plenary.nvim",
    },

    {
        'sbulav/nredir.nvim'
    },
    -- {
    --     "willothy/flatten.nvim",
    --     config = true,
    --     lazy = false,
    --     priority = 1001,
    -- },
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
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            enable_check_bracket_line = true,
            ignored_next_char = "[%w%.]",
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                manual_position = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        },
    },
    {
        "zakissimo/smoji.nvim",
        config = function()
            require("smoji")
            vim.keymap.set("n", "<Leader><Leader>e", "<CMD>Smoji<CR>")
        end
    },
    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true,
            })
            vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>")
        end,
    },

    {
        "zakissimo/run.nvim",
        config = function()
            vim.keymap.set("n", "<Leader>cc", "<CMD>lua require'run'.cmd()<CR>")
        end,
        dev = false,
    },
    {
        "zakissimo/term.nvim",
        config = function()
            require("term").setup({
                spawn = false,
            })
            vim.keymap.set({ "n", "t" }, "<Leader>t", "<CMD>lua require'term'.toggle()<CR>")
        end,
        dev = false,
    },
}
