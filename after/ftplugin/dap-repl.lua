local dap = require("dap")

vim.keymap.set("n", "r", dap.continue)
vim.keymap.set("n", "n", dap.step_over)
vim.keymap.set("n", "i", dap.step_into)
vim.keymap.set("n", "o", dap.step_out)
