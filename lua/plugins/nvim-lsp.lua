return {
    {
        "sheerun/vim-polyglot",
    },
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },

            { "mfussenegger/nvim-dap" },
            { "rcarriga/nvim-dap-ui" },

            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },

            { "stevearc/conform.nvim" },

            {
                "j-hui/fidget.nvim",
                opts = { window = { blend = 0 } },
                branch = "legacy",
            },

            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup({
                        library = { plugins = { "nvim-dap-ui" }, types = true },
                    })
                end,
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
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}
