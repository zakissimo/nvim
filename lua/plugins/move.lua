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
            { "<Leader>m", "<CMD>HookToggle<CR>", { "t", "n" } },
            { "<M-7>", "<CMD>HookPull 1<CR>", { "t", "n" } },
            { "<M-8>", "<CMD>HookPull 2<CR>", { "t", "n" } },
            { "<M-9>", "<CMD>HookPull 3<CR>", { "t", "n" } },
            { "<M-0>", "<CMD>HookPull 4<CR>", { "t", "n" } },
            { "<M-u>", "<CMD>HookPull 5<CR>", { "t", "n" } },
            { "<M-i>", "<CMD>HookPull 6<CR>", { "t", "n" } },
            { "<M-o>", "<CMD>HookPull 7<CR>", { "t", "n" } },
            { "<M-p>", "<CMD>HookPull 8<CR>", { "t", "n" } },
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
            { "<Leader>gh", "<CMD>FzfLua help_tags<CR>", "n" },
            { "<Leader>gt", "<CMD>FzfLua lsp_typedefs<CR>", "n" },
            { "<Leader>b", "<CMD>FzfLua buffers<CR>", "n" },
            { "<Leader>r", "<CMD>FzfLua registers<CR>", "n" },
            { "<Leader>l", "<CMD>FzfLua live_grep<CR>", "n" },
            { "<Leader>f", "<CMD>FzfLua files<CR>", "n" },
            { "<Leader>gf", "<CMD>FzfLua git_files<CR>", "n" },
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
        "fedepujol/move.nvim",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set("v", "J", ":MoveBlock(1)<CR>", opts)
            vim.keymap.set("v", "K", ":MoveBlock(-1)<CR>", opts)
        end,
    },
}
