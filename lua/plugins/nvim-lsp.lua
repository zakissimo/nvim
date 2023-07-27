return {
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },

            {
                "j-hui/fidget.nvim",
                opts = { window = { blend = 0 } },
                branch = "legacy",
            },

            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup({})
                end,
            },

            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
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
