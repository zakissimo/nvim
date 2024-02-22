local set = vim.opt

set.autochdir = false
set.cursorline = true
set.fileencoding = "utf-8"
set.ignorecase = true
set.mouse = "a"

set.number = true
set.relativenumber = true
set.colorcolumn = "81"
vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })

set.scrolloff = 5
set.pumheight = 10

set.smartcase = true
set.smartindent = true

set.splitbelow = true
set.splitright = true

-- set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"

set.swapfile = false
set.backup = false
set.undodir = { os.getenv("HOME") .. "/.vim/undodir" }
set.undofile = true

set.hlsearch = true
set.incsearch = true

set.timeoutlen = 350
set.ttimeoutlen = 50
set.wrap = false
set.list = true
set.listchars = {
    tab = ">-",
    trail = ".",
}

set.spelllang = "en,fr"
set.spell = true

vim.cmd("set fillchars+=eob:│")

set.ch = 0
set.ls = 3
