return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            enable_check_bracket_line = true,
            ignored_next_char = "[%w%.]",
            fast_wrap = {
                map = "<C-]>",
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
