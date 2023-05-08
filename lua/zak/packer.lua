local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })
    use({ "nvim-lua/plenary.nvim" })

    use({ "zakissimo/run.nvim" })
    use({ "zakissimo/term.nvim" })
    use({
        "zakissimo/hook.nvim",
        config = function()
            require("hook").setup({
                prefix = "",
                -- win_w = 31,
                -- win_h = 7,
            })
            local opts = { noremap = true, silent = true }
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
    })

    use({ "stevearc/dressing.nvim" })
    use({
        "ibhagwan/fzf-lua",
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    use("folke/tokyonight.nvim")
    use({ "rose-pine/neovim", as = "rose-pine" })
    use("nvim-lualine/lualine.nvim")
    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    use("mbbill/undotree")

    use("lewis6991/gitsigns.nvim")
    use("kdheepak/lazygit.nvim")
    use("tpope/vim-fugitive")

    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })
    use({ "rcarriga/nvim-notify" })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    use({ "norcalli/nvim-colorizer.lua" })

    use("MunifTanjim/nui.nvim")
    use("dpayne/CodeGPT.nvim")
    use({
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    })
    use({
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
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
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
