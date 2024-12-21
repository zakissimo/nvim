local set = vim.opt

set.mouse = "a"

set.autochdir = false

set.number = true
set.relativenumber = true

set.wrap = false
set.linebreak = true
set.breakindent = true
set.formatoptions = "jcql"
set.textwidth = 80
set.colorcolumn = "+1"

vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
set.cursorline = true

set.scrolloff = 5

set.ignorecase = true
set.smartcase = true
set.smartindent = true

set.splitbelow = true
set.splitright = true

set.foldexpr = "nvim_treesitter#foldexpr()"

set.backup = false
set.swapfile = false
set.undofile = true
set.undodir = { os.getenv("HOME") .. "/.vim/undodir" }

set.hlsearch = true
set.incsearch = true

set.timeoutlen = 350
set.ttimeoutlen = 50

set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.list = true
set.listchars = {
  tab = ">-",
  trail = ".",
}

-- set.spell = true
-- set.spelllang = "en,fr"
-- set.spelloptions = "camel"

vim.cmd("set fillchars+=eob:│")

set.ch = 1
