return {
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
    {
        "zakissimo/hook.nvim",
        config = function()
            require("hook").setup({
                prefix = "",
                suffix = "󰷫",
            })
            vim.keymap.set({ "t", "n" }, "<Leader>m", "<CMD>HookToggle<CR>")
            vim.keymap.set({ "t", "n" }, "<M-7>", "<CMD>HookPull 1<CR>")
            vim.keymap.set({ "t", "n" }, "<M-8>", "<CMD>HookPull 2<CR>")
            vim.keymap.set({ "t", "n" }, "<M-9>", "<CMD>HookPull 3<CR>")
            vim.keymap.set({ "t", "n" }, "<M-0>", "<CMD>HookPull 4<CR>")
            vim.keymap.set({ "t", "n" }, "<M-u>", "<CMD>HookPull 5<CR>")
            vim.keymap.set({ "t", "n" }, "<M-i>", "<CMD>HookPull 6<CR>")
            vim.keymap.set({ "t", "n" }, "<M-o>", "<CMD>HookPull 7<CR>")
            vim.keymap.set({ "t", "n" }, "<M-p>", "<CMD>HookPull 8<CR>")
        end,
        dev = true,
    },
}
