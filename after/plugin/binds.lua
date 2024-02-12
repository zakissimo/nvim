vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<C-V>", '"+p', opts)

vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv")

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("n", "<", "V<", opts)
vim.keymap.set("n", ">", "V>", opts)

vim.keymap.set({ "n", "i" }, "<F1>", "<Esc>", opts)

vim.keymap.set("n", "<esc>", "<CMD>noh<CR><esc>", opts)
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

vim.keymap.set("c", "<C-p>", "<Up>", opts)
vim.keymap.set("c", "<C-n>", "<Down>", opts)
vim.keymap.set("c", "<C-a>", "<Home>", opts)
vim.keymap.set("c", "<C-e>", "<End>", opts)
