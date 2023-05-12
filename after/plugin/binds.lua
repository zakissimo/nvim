vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("n", "<", "V<", opts)
vim.keymap.set("n", ">", "V>", opts)

vim.keymap.set({ "n", "i" }, "<F1>", "<Esc>", opts)

vim.keymap.set({ "n", "i" }, "<C-n>", function()
    if vim.bo.filetype == "netrw" then
        vim.cmd("bprev")
    else
        vim.cmd("Ex")
    end
end, opts)

vim.keymap.set("n", "<esc><esc>", "<CMD>noh<CR>", opts)
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", opts)

vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set({ "n", "v" }, "H", "^", opts)
vim.keymap.set({ "n", "v" }, "L", "$", opts)

vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)

vim.keymap.set("n", "<leader>xx", "<CMD>!chmod +x %<CR>", opts)
vim.keymap.set("n", "<leader>ls", "<CMD>Lazy sync<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<CMD>w!<CR><CMD>source %<CR>", opts)

vim.keymap.set("n", "<C-Down>", "<CMD>resize -2<CR>", opts)
vim.keymap.set("n", "<C-Up>", "<CMD>resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", opts)
