local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

require("lazy").setup({
    {
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({ window = { blend = 0 } })
        end,
    },
    { "folke/neodev.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },

    {
        "zakissimo/run.nvim",
        config = function()
            vim.keymap.set("n", "<Leader>cc", "<CMD>lua require'run'.cmd()<CR>", opts)
        end,
    },
    {
        "zakissimo/term.nvim",
        config = function()
            require("term").setup({
                spawn = false,
            })
            vim.keymap.set("n", "<M-m>", "<CMD>lua require'term'.toggle()<CR>", opts)
        end,
    },
    {
        "zakissimo/hook.nvim",
        config = function()
            require("hook").setup({
                prefix = "",
            })
            vim.keymap.set({ "t", "n" }, "<M-n>", "<CMD>lua require'hook'.toggle()<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-7>", "<CMD>lua require'hook'.pull(1)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-8>", "<CMD>lua require'hook'.pull(2)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-9>", "<CMD>lua require'hook'.pull(3)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-0>", "<CMD>lua require'hook'.pull(4)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-u>", "<CMD>lua require'hook'.pull(5)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-i>", "<CMD>lua require'hook'.pull(6)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-o>", "<CMD>lua require'hook'.pull(7)<CR>", opts)
            vim.keymap.set({ "t", "n" }, "<M-p>", "<CMD>lua require'hook'.pull(8)<CR>", opts)
        end,
    },

    { "stevearc/dressing.nvim" },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<Leader>gh", "<CMD>FzfLua help_tags<CR>", opts)
            vim.keymap.set("n", "<Leader>fb", "<CMD>FzfLua buffers<CR>", opts)
            vim.keymap.set("n", "<Leader>fr", "<CMD>FzfLua registers<CR>", opts)
            vim.keymap.set("n", "<Leader>ft", "<CMD>FzfLua tabs<CR>", opts)
            vim.keymap.set("n", "<Leader>fl", "<CMD>FzfLua live_grep<CR>", opts)
            vim.keymap.set("n", "<Leader>ff", "<CMD>FzfLua files<CR>", opts)
            vim.keymap.set("n", "<Leader>gf", "<CMD>FzfLua git_files<CR>", opts)
            vim.keymap.set("n", "<Leader>o", "<CMD>lua require'fzf-lua'.files({ cwd='~' })<CR>", opts)
        end,
    },

    { "folke/tokyonight.nvim" },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("zak.themes.rose")
            vim.cmd("colorscheme rose-pine")
        end,
    },
    { "nvim-lualine/lualine.nvim" },
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

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<Leader>uu", "<CMD>UndotreeToggle<CR>", opts)
        end,
    },

    { "lewis6991/gitsigns.nvim" },
    {
        "kdheepak/lazygit.nvim",
        config = function()
            vim.keymap.set("n", "<Leader>gg", "<CMD>LazyGit<CR>", opts)
        end,
    },
    { "tpope/vim-fugitive" },

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
    { "rcarriga/nvim-notify" },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    { "norcalli/nvim-colorizer.lua" },

    { "MunifTanjim/nui.nvim" },
    {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "onsails/lspkind-nvim" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    },
})
