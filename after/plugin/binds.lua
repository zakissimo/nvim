vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<esc><esc>", "<CMD>noh<CR>", opts)
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", opts)
vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>", opts)

vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>xx", "<CMD>!chmod +x %<CR>", opts)
vim.keymap.set("n", "<leader>pr", "<CMD>PackerSync<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<CMD>w!<CR><CMD>source %<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<leader>s", [[<CMD>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<F2>", "<CMD>lua vim.lsp.buf.format()<CR>", opts)

vim.keymap.set("n", "<C-Down>", "<CMD>resize -2<CR>", opts)
vim.keymap.set("n", "<C-Up>", "<CMD>resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", opts)

vim.keymap.set("n", "<Leader>uu", "<CMD>UndotreeToggle<CR>", opts)
vim.keymap.set("n", "<Leader>gg", "<CMD>LazyGit<CR>", opts)

vim.keymap.set("n", "<Leader>gh", "<CMD>FzfLua help_tags<CR>", opts)
vim.keymap.set("n", "<Leader>fb", "<CMD>FzfLua buffers<CR>", opts)
vim.keymap.set("n", "<Leader>fr", "<CMD>FzfLua registers<CR>", opts)
vim.keymap.set("n", "<Leader>ft", "<CMD>FzfLua tabs<CR>", opts)
vim.keymap.set("n", "<Leader>fl", "<CMD>FzfLua live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>ff", "<CMD>FzfLua git_files<CR>", opts)
vim.keymap.set("n", "<Leader>o", "<CMD>lua require'fzf-lua'.files({ cwd='~' })<CR>", opts)

vim.keymap.set("n", "<Leader>cc", "<CMD>lua require'run'.cmd()<CR>", opts)
vim.keymap.set("n", "<Leader>tt", "<CMD>lua require'term'.toggle()<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-n>", "<CMD>lua require'hook'.toggle()<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-7>", "<CMD>lua require'hook'.pull(1)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-8>", "<CMD>lua require'hook'.pull(2)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-9>", "<CMD>lua require'hook'.pull(3)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-0>", "<CMD>lua require'hook'.pull(4)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-u>", "<CMD>lua require'hook'.pull(5)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-i>", "<CMD>lua require'hook'.pull(6)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-o>", "<CMD>lua require'hook'.pull(7)<CR>", opts)
vim.keymap.set({"t", "n"}, "<M-p>", "<CMD>lua require'hook'.pull(8)<CR>", opts)
