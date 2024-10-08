local set = vim.opt
local opt = { noremap = true }
local bufmap = vim.api.nvim_buf_set_keymap

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = vim.api.nvim_create_augroup("TabSpace", { clear = true }),
    callback = function()
        set.ls = 3
        local ft = vim.bo.filetype
        if ft == "make" then
            set.tabstop = 4
            set.shiftwidth = 4
            set.expandtab = false
        elseif
            ft == "nix"
            or ft == "css"
            or ft == "html"
            or ft == "javascript"
            or ft == "typescript"
            or ft == "svelte"
            or ft == "json"
        then
            set.tabstop = 2
            set.shiftwidth = 2
            set.expandtab = true
        else
            set.tabstop = 4
            set.shiftwidth = 4
            set.expandtab = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = vim.api.nvim_create_augroup("YankHl", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = vim.api.nvim_create_augroup("TermBinds", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        if vim.fn.win_gettype() ~= "popup" then
            bufmap(0, "t", "<Esc>", [[<C-\><C-n>]], opt)
            bufmap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opt)
            bufmap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opt)
            bufmap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opt)
            bufmap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opt)
            bufmap(0, "t", "<C-Down>", [[<C-\><C-n>":resize -2<CR>"]], opt)
            bufmap(0, "t", "<C-Up>", [[<C-\><C-n>":resize +2<CR>"]], opt)
            bufmap(0, "t", "<C-Left>", [[<C-\><C-n>":vertical resize -2<CR>"]], opt)
            bufmap(0, "t", "<C-Right>", [[<C-\><C-n>":vertical resize +2<CR>"]], opt)
        end
    end,
})
