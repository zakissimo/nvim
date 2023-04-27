vim.g.mapleader = " "

vim.keymap.set("n", "<esc><esc>", ":noh<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>xx", ":!chmod +x %<CR>")
vim.keymap.set("n", "<leader>pr", ":PackerSync<CR>")
vim.keymap.set("n", "<leader>lr", ":w!<CR>:source %<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<F2>", ":lua vim.lsp.buf.format()<CR>")

vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n", "<Leader>uu", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<Leader>gg", ":LazyGit<CR>")

vim.keymap.set("n", "<Leader>gh", ":FzfLua help_tags<CR>")
vim.keymap.set("n", "<Leader>fb", ":FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fr", ":FzfLua registers<CR>")
vim.keymap.set("n", "<Leader>ft", ":FzfLua tabs<CR>")
vim.keymap.set("n", "<Leader>fl", ":FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>ff", ":FzfLua git_files<CR>")
vim.keymap.set("n", "<Leader>o", ":lua require'fzf-lua'.files({ cwd='~' })<CR>")

vim.keymap.set("n", "<Leader>cc", ":lua require'run'.cmd()<CR>")
vim.keymap.set("n", "<Leader>tt", ":lua require'term'.toggle()<CR>")
vim.keymap.set("n", "<M-n>", ":lua require'hook'.toggle()<CR>")
vim.keymap.set("n", "<M-7>", ":lua require'hook'.pull(1)<CR>")
vim.keymap.set("n", "<M-8>", ":lua require'hook'.pull(2)<CR>")
vim.keymap.set("n", "<M-9>", ":lua require'hook'.pull(3)<CR>")
vim.keymap.set("n", "<M-0>", ":lua require'hook'.pull(4)<CR>")
vim.keymap.set("n", "<M-u>", ":lua require'hook'.pull(5)<CR>")
vim.keymap.set("n", "<M-i>", ":lua require'hook'.pull(6)<CR>")
vim.keymap.set("n", "<M-o>", ":lua require'hook'.pull(7)<CR>")
vim.keymap.set("n", "<M-p>", ":lua require'hook'.pull(8)<CR>")
