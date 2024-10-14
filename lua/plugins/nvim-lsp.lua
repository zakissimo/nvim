return {
    -- {
    --     "sheerun/vim-polyglot",
    -- },
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },

            { "neomake/neomake" },

            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup({
                        library = { plugins = { "nvim-dap-ui" }, types = true },
                    })
                end,
            },
            {
                "mrcjkb/rustaceanvim",
                version = "^5", -- Recommended
                lazy = false, -- This plugin is already lazy
                config = function()
                    vim.g.rustaceanvim = {
                        tools = {
                            float_win_config = {
                                border = "rounded",
                            },
                        },
                        server = {
                            on_attach = require("zak.lsp").on_attach,
                        },
                    }
                end,
            },

            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },

            { "mfussenegger/nvim-dap" },
            { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    require("nvim-dap-virtual-text").setup()
                end,
            },

            { "stevearc/conform.nvim" },
            { "mfussenegger/nvim-lint" },

            {
                "j-hui/fidget.nvim",
                opts = { window = { blend = 0 } },
                branch = "legacy",
            },

            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup()
                end,
            },
        },
    },
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
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").prefer_git = false
        end,
    },
}
