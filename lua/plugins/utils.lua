return {
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
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.comment").setup()
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
}
