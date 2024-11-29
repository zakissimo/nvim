return {
    {
        "zakissimo/hooked.nvim",
        lazy = false,
        config = function()
            require("hooked").setup({
                prefix = "",
                suffix = "󰷫",
            })
        end,
        dev = true,
        keys = {
            { "<Leader>m", "<CMD>HookedToggle<CR>", { "n" } },
            { "<M-m>",     "<CMD>HookedMark<CR>",   { "n" } },
            { "<M-j>",     "<CMD>HookedPull 1<CR>", { "n" } },
            { "<M-k>",     "<CMD>HookedPull 2<CR>", { "n" } },
            { "<M-u>",     "<CMD>HookedPull 3<CR>", { "n" } },
            { "<M-i>",     "<CMD>HookedPull 4<CR>", { "n" } },
            { "<M-7>",     "<CMD>HookedPull 5<CR>", { "n" } },
            { "<M-8>",     "<CMD>HookedPull 6<CR>", { "n" } },
        },
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                float = {
                    padding = 10,
                    win_options = {
                        winblend = 0,
                    },
                },
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>")
            vim.keymap.set("n", "<Leader>n", "<CMD>lua require'oil'.toggle_float()<CR>")
        end,
    },
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "kyazdani42/nvim-web-devicons" },
        keys = {
            { "<Leader>h", "<CMD>FzfLua help_tags<CR>",                       "n" },
            { "<Leader>l", "<CMD>FzfLua live_grep<CR>",                       "n" },
            { "<Leader>f", "<CMD>FzfLua files<CR>",                           "n" },
            { "<Leader>g", "<CMD>FzfLua git_files<CR>",                       "n" },
            { "<Leader>o", "<CMD>lua require'fzf-lua'.files({ cwd='~'})<CR>", "n" },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },
}
