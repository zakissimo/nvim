vim.notify = require("notify").setup({
    background_colour = "#000000",
    max_width = 70,
})

vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
end

vim.opt.termguicolors = true
require("colorizer").setup()

vim.api.nvim_set_hl(0, "FloatBorder", {bg='NONE', fg='White'})
local synID = vim.fn.hlID('FloatBorder')
local _ = vim.fn.synIDattr(synID, 'fg')
