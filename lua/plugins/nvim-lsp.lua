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
            { "williamboman/mason.nvim",          config = true },
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

            { "nvimtools/none-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = function()
                    require("lsp_lines").setup()
                    vim.keymap.set("", "<Leader><Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
                end,
            },

            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup()
                end
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
