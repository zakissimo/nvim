return {
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
            require("mini.pairs").setup({
                -- In which modes mappings from this `config` should be created
                modes = { insert = true, command = false, terminal = false },

                -- Global mappings. Each right hand side should be a pair information, a
                -- table with at least these fields (see more in |MiniPairs.map|):
                -- - <action> - one of 'open', 'close', 'closeopen'.
                -- - <pair> - two character string for pair to be used.
                -- By default pair is not inserted after `\`, quotes are not recognized by
                -- `<CR>`, `'` does not insert pair after a letter.
                -- Only parts of tables can be tweaked (others will use these defaults).
                mappings = {
                    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

                    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

                    ['"'] = {
                        action = "closeopen",
                        pair = '""',
                        neigh_pattern = "[^\\].",
                        register = { cr = false },
                    },
                    ["'"] = {
                        action = "closeopen",
                        pair = "''",
                        neigh_pattern = "[^%a\\<&,:\\].",
                        register = { cr = false },
                    },
                    ["`"] = {
                        action = "closeopen",
                        pair = "``",
                        neigh_pattern = "[^\\].",
                        register = { cr = false },
                    },
                },
            })
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
