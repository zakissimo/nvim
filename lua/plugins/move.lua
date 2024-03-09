return {
    {
        "zakissimo/hook.nvim",
        lazy = false,
        config = function()
            require("hook").setup({
                prefix = "",
                suffix = "󰷫",
            })
        end,
        dev = true,
        keys = {
            { "<Leader>m", "<CMD>HookToggle<CR>", { "n" } },
            { "<M-7>", "<CMD>HookPull 1<CR>", { "n", "i" } },
            { "<M-8>", "<CMD>HookPull 2<CR>", { "n", "i" } },
            { "<M-9>", "<CMD>HookPull 3<CR>", { "n", "i" } },
            { "<M-0>", "<CMD>HookPull 4<CR>", { "n", "i" } },
            { "<M-u>", "<CMD>HookPull 5<CR>", { "n", "i" } },
            { "<M-i>", "<CMD>HookPull 6<CR>", { "n", "i" } },
            { "<M-o>", "<CMD>HookPull 7<CR>", { "n", "i" } },
            { "<M-p>", "<CMD>HookPull 8<CR>", { "n", "i" } },
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
            vim.keymap.set("n", "<Leader>n", "<CMD>lua require'oil'.toggle_float()<CR>")
        end,
    },
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "kyazdani42/nvim-web-devicons" },
        keys = {
            { "<Leader>h", "<CMD>FzfLua help_tags<CR>", "n" },
            { "<Leader>b", "<CMD>FzfLua buffers<CR>", "n" },
            { "<Leader>r", "<CMD>FzfLua registers<CR>", "n" },
            { "<Leader>l", "<CMD>FzfLua live_grep<CR>", "n" },
            { "<Leader>f", "<CMD>FzfLua files<CR>", "n" },
            { "<Leader>g", "<CMD>FzfLua git_files<CR>", "n" },
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
