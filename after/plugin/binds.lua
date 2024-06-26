vim.g.mapleader = " "

local map = function(mode, keys, func, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, keys, func, opts)
end

map({ "n", "v" }, "<Space>", "<Nop>")

map("v", "<leader>y", '"+y')
map({ "n", "v" }, "<leader>p", '"+p')

map("v", "J", ":move '>+1<CR>gv=gv")
map("v", "K", ":move '<-2<CR>gv=gv")

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "V<")
map("n", ">", "V>")

map({ "n", "i" }, "<F1>", "<Esc>")

map("n", "<esc>", "<CMD>noh<CR><esc>")
map("n", "<C-s>", "<CMD>w<CR>")

map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")

map("n", "<leader>t", "<CMD>:term<CR>")
map("n", "<leader>xx", "<CMD>!chmod +x %<CR>")
map("n", "<leader>r", "<CMD>Lazy sync<CR>")

map("n", "<C-Down>", "<CMD>resize -2<CR>")
map("n", "<C-Up>", "<CMD>resize +2<CR>")
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>")
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>")

map({ "c", "i" }, "<C-a>", "<Home>")
map({ "c", "i" }, "<C-e>", "<End>")
