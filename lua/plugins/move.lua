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
            { "<M-7>", "<CMD>HookPull 1<CR>", { "n" } },
            { "<M-8>", "<CMD>HookPull 2<CR>", { "n" } },
            { "<M-9>", "<CMD>HookPull 3<CR>", { "n" } },
            { "<M-0>", "<CMD>HookPull 4<CR>", { "n" } },
            { "<M-u>", "<CMD>HookPull 5<CR>", { "n" } },
            { "<M-i>", "<CMD>HookPull 6<CR>", { "n" } },
            { "<M-o>", "<CMD>HookPull 7<CR>", { "n" } },
            { "<M-p>", "<CMD>HookPull 8<CR>", { "n" } },
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
            { "<Leader>p", "<CMD>FzfLua git_files<CR>", "n" },
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
    {
        "echasnovski/mini.move",
        version = "*",
        config = function()
            require("mini.move").setup({
                mappings = {
                    -- Move visual selection in Visual mode.
                    left = "",
                    right = "",
                    down = "<M-j>",
                    up = "<M-k>",

                    -- Move current line in Normal mode
                    line_left = "",
                    line_right = "",
                    line_down = "<M-j>",
                    line_up = "<M-k>",
                },
                options = {
                    -- Automatically reindent selection during linewise vertical move
                    reindent_linewise = true,
                },
            })
        end,
    },
}
