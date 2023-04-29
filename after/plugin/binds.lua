vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<esc><esc>", ":noh<CR>", opts)
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>xx", ":!chmod +x %<CR>", opts)
vim.keymap.set("n", "<leader>pr", ":PackerSync<CR>", opts)
vim.keymap.set("n", "<leader>lr", ":w!<CR>:source %<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<F2>", ":lua vim.lsp.buf.format()<CR>", opts)

vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<Leader>uu", ":UndotreeToggle<CR>", opts)
vim.keymap.set("n", "<Leader>gg", ":LazyGit<CR>", opts)

vim.keymap.set("n", "<Leader>gh", ":FzfLua help_tags<CR>", opts)
vim.keymap.set("n", "<Leader>fb", ":FzfLua buffers<CR>", opts)
vim.keymap.set("n", "<Leader>fr", ":FzfLua registers<CR>", opts)
vim.keymap.set("n", "<Leader>ft", ":FzfLua tabs<CR>", opts)
vim.keymap.set("n", "<Leader>fl", ":FzfLua live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>ff", ":FzfLua git_files<CR>", opts)
vim.keymap.set("n", "<Leader>o", ":lua require'fzf-lua'.files({ cwd='~' })<CR>", opts)

vim.keymap.set("n", "<Leader>cc", ":lua require'run'.cmd()<CR>", opts)
vim.keymap.set("n", "<Leader>tt", ":lua require'term'.toggle()<CR>", opts)
vim.keymap.set("n", "<M-n>", ":lua require'hook'.toggle()<CR>", opts)
vim.keymap.set("n", "<M-7>", ":lua require'hook'.pull(1)<CR>", opts)
vim.keymap.set("n", "<M-8>", ":lua require'hook'.pull(2)<CR>", opts)
vim.keymap.set("n", "<M-9>", ":lua require'hook'.pull(3)<CR>", opts)
vim.keymap.set("n", "<M-0>", ":lua require'hook'.pull(4)<CR>", opts)
vim.keymap.set("n", "<M-u>", ":lua require'hook'.pull(5)<CR>", opts)
vim.keymap.set("n", "<M-i>", ":lua require'hook'.pull(6)<CR>", opts)
vim.keymap.set("n", "<M-o>", ":lua require'hook'.pull(7)<CR>", opts)
vim.keymap.set("n", "<M-p>", ":lua require'hook'.pull(8)<CR>", opts)
