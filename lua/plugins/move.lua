return {
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
            vim.keymap.set({ "t", "n" }, "<Leader>n", "<CMD>lua require'oil'.toggle_float()<CR>")
        end,
    },
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<Leader>gh", "<CMD>FzfLua help_tags<CR>")
            vim.keymap.set("n", "<Leader>b", "<CMD>FzfLua buffers<CR>")
            vim.keymap.set("n", "<Leader>r", "<CMD>FzfLua registers<CR>")
            -- vim.keymap.set("n", "<Leader>t", "<CMD>FzfLua tabs<CR>")
            vim.keymap.set("n", "<Leader>l", "<CMD>FzfLua live_grep<CR>")
            vim.keymap.set("n", "<Leader>f", "<CMD>FzfLua files<CR>")
            vim.keymap.set("n", "<Leader>gf", "<CMD>FzfLua git_files<CR>")
            vim.keymap.set("n", "<Leader>o", "<CMD>lua require'fzf-lua'.files({ cwd='~' })<CR>")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        tag = "0.1.1",
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },
}
