return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
      },
      {
        "mason-org/mason-lspconfig.nvim",
        config = function()
          local lsp_config = require("lspconfig")
          local lsp_utils = require("config.utils.lsp")
          local servers = lsp_utils.servers()

          local capabilities = lsp_utils.capabilities()
          local on_attach = lsp_utils.on_attach

          vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = on_attach,
          })

          -- for server, config in pairs(servers) do
          --   config.capabilities = capabilities
          --   lsp_config[server].setup(config)
          -- end

          require("mason").setup()
          require("mason-lspconfig").setup({
            automatic_enable = true,
          })
        end,
      },
      {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
        config = function()
          local lsp_utils = require("config.utils.lsp")
          vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {},
            -- LSP configuration
            server = {
              on_attach = lsp_utils.on_attach,
              default_settings = {
                -- rust-analyzer language server configuration
                ["rust-analyzer"] = {},
              },
            },
            -- DAP configuration
            dap = {},
          }
        end,
      },
      {
        "saghen/blink.cmp",
        version = "*",
        lazy = false,
        opts = {
          keymap = {
            preset = "default",
            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
          },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
          },
          sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
              },
            },
          },
          completion = { accept = { auto_brackets = { enabled = true } } },
          signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },

      {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
          formatters_by_ft = {
            python = { "autopep8" },
            sh = { "shfmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            toml = { "taplo" },
          },
          format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end,
          formatters = {
            prettierd = {
              prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
            },
            shfmt = {
              prepend_args = { "--indent", "4" },
            },
            stylua = {
              prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
            },
            clang_format = {
              prepend_args = function(_, _)
                local format_files = vim.fs.find(".clang-format", { upward = true, stop = vim.fn.expand("$HOME") })
                if #format_files == 0 then
                  return {
                    "-style",
                    "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left, ColumnLimit: 120}",
                  }
                end
                return {}
              end,
            },
          },
        },
      },

      {
        "j-hui/fidget.nvim",
        opts = { window = { blend = 0 } },
        branch = "legacy",
      },
    },
  },
}
