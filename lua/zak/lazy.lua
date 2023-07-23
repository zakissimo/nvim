local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
    {
        "lewis6991/impatient.nvim",
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    {
        "j-hui/fidget.nvim",
        opts = { window = { blend = 0 } },
        branch = "legacy",
    },
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify" },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true })
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                relative = "editor",
                win_options = {
                    winblend = 0,
                },
                select = {
                    win_options = {
                        winblend = 0,
                    },
                },
            },
        },
    },
    { "nvim-lua/plenary.nvim" },

    {
        "willothy/flatten.nvim",
        config = true,
        lazy = false,
        priority = 1001,
    },

    {
        "zakissimo/run.nvim",
        config = function()
            vim.keymap.set("n", "<Leader>cc", "<CMD>lua require'run'.cmd()<CR>")
        end,
        dev = false,
    },
    {
        "zakissimo/term.nvim",
        config = function()
            require("term").setup({
                spawn = false,
            })
            vim.keymap.set({ "n", "i", "t" }, "<Leader>t", "<CMD>lua require'term'.toggle()<CR>")
        end,
        dev = false,
    },
    {
        "zakissimo/hook.nvim",
        config = function()
            require("hook").setup({
                prefix = "",
                suffix = "󰷫",
            })
            vim.keymap.set({ "t", "n" }, "<Leader>m", "<CMD>lua require'hook'.toggle()<CR>")
            vim.keymap.set({ "t", "n" }, "<M-7>", "<CMD>lua require'hook'.pull(1)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-8>", "<CMD>lua require'hook'.pull(2)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-9>", "<CMD>lua require'hook'.pull(3)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-0>", "<CMD>lua require'hook'.pull(4)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-u>", "<CMD>lua require'hook'.pull(5)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-i>", "<CMD>lua require'hook'.pull(6)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-o>", "<CMD>lua require'hook'.pull(7)<CR>")
            vim.keymap.set({ "t", "n" }, "<M-p>", "<CMD>lua require'hook'.pull(8)<CR>")
        end,
        dev = true,
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                float = {
                    padding = 10,
                    win_options = {
                        winblend = 0,
                    },
                },
            })
            vim.keymap.set({ "n", "i" }, "<Leader>n", "<CMD>lua require'oil'.toggle_float()<CR>")
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<Leader>gh", "<CMD>FzfLua help_tags<CR>")
            vim.keymap.set("n", "<Leader>b", "<CMD>FzfLua buffers<CR>")
            vim.keymap.set("n", "<Leader>r", "<CMD>FzfLua registers<CR>")
            -- vim.keymap.set("n", "<Leader>t", "<CMD>FzfLua tabs<CR>")
            vim.keymap.set("n", "<Leader>l", "<CMD>FzfLua live_grep<CR>")
            vim.keymap.set("n", "<Leader>f", "<CMD>FzfLua files<CR>")
            vim.keymap.set("n", "<Leader>gf", "<CMD>FzfLua git_files<CR>")
            vim.keymap.set("n", "<Leader>o", "<CMD>lua require'fzf-lua'.files({ cwd='~' })<CR>")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    { "norcalli/nvim-colorizer.lua" },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "folke/tokyonight.nvim",
        config = function()
            -- require("zak.themes.tokyo")
            -- vim.cmd("colorscheme tokyonight")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("zak.themes.rose")
            vim.cmd("colorscheme rose-pine")
        end,
    },

    {
        "alvarosevilla95/luatab.nvim",
        config = function()
            require("luatab").setup({})
        end,
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup()
        end,
    },
    { "nvim-lualine/lualine.nvim" },

    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    { "lewis6991/gitsigns.nvim" },
    {
        "NeogitOrg/neogit",
        config = function()
            require("neogit").setup()
            vim.keymap.set("n", "<Leader>gg", "<CMD>Neogit<CR>")
        end,
    },
    { "sindrets/diffview.nvim" },

    {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    },
    -- {
    --     "sourcegraph/sg.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --
    --     build = "nvim -l build/init.lua",
    -- },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<Leader>uu", "<CMD>UndotreeToggle<CR>")
        end,
    },

    { "RaafatTurki/hex.nvim",
        config = function()
            require("hex").setup({})
        end,
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({})
        end,
    },

    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim" },

    { "jose-elias-alvarez/null-ls.nvim" },
    { "jay-babu/mason-null-ls.nvim" },

    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "dmitmel/cmp-cmdline-history" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },

    { "onsails/lspkind-nvim" },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
    },
}

local opts = {
    diff = {
        cmd = "diffview.nvim",
    },
    dev = {
        path = "~/Code/nvim-plugins",
        patterns = {},
        fallback = true,
    },
    debug = false,
}

require("lazy").setup(plugins, opts)
