local rose_pine_ok, rose_pine = pcall (require ,"rose-pine")
local tokyonight_ok, tokyonight = pcall (require ,"tokyonight")
local notify_ok, _ = pcall (require ,"notify")

local rose_pine_setup = {
    --- @usage 'main' | 'moon'
    dark_variant = "main",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = true,
    disable_italics = true,
    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = "base",
        panel = "surface",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",
        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",
        headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
        },
        -- or set all headings at once
        -- headings = 'subtle'
    },
    -- Change specific vim highlight groups
    highlight_groups = {
        ColorColumn = { bg = "rose" },
        CursorLine = { bg = "foam", blend = 10 },
        StatusLine = { fg = "love", bg = "love", blend = 10 },
    },
}

local tokyonight_setup = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
    --- You can override specific color groups to use other groups or a hex color
    --- fucntion will be called with a ColorScheme table
    on_colors = function(colors) end,
    --- You can override specific highlights to use other groups or a hex color
    --- fucntion will be called with a Highlights and ColorScheme table
    on_highlights = function(highlights, colors) end,
}

if rose_pine_ok then
    rose_pine.setup(rose_pine_setup)
    vim.cmd("colorscheme rose-pine")
elseif tokyonight_ok then
    tokyonight.setup(tokyonight_setup)
    vim.cmd("colorscheme tokyonight")
end

if notify_ok then
    vim.notify = require("notify").setup({
        background_colour = "#000000",
        render = "compact",
        max_width = 50,
        top_down = false,
    })

    vim.notify = function(msg, ...)
        if msg:match("warning: multiple different client offset_encodings") then
            return
        end
    end
end

vim.opt.termguicolors = true

require("colorizer").setup()

vim.api.nvim_set_hl(0, "FloatBorder", {bg='NONE', fg='White'})
local synID = vim.fn.hlID('FloatBorder')
local _ = vim.fn.synIDattr(synID, 'fg')
