return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          local lsp_utils = require("config.utils.lsp")
          lsp_utils.load_system_servers()
          require("mason-lspconfig").setup({
            handlers = {
              function(server_name)
                local server = lsp_utils.get_mason_server(server_name) or {}
                server.capabilities = lsp_utils.capabilities()
                require("lspconfig")[server_name].setup(server)
              end,
            },
          })
        end,
      },
      {
        "saghen/blink.cmp",
        version = "v0.*",
        lazy = false,
        opts = {
          keymap = {
            preset = "default",

            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-j>"] = { "scroll_documentation_down", "fallback" },
          },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
          },
          sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
          },
          completion = { accept = { auto_brackets = { enabled = true } } },
          providers = {
            lsp = { fallback_for = { "lazydev" } },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
          },
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
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        config = function()
          ---@diagnostic disable-next-line: inject-field
          vim.g.rustaceanvim = {
            tools = {
              float_win_config = {
                border = "rounded",
              },
              executor = "quickfix",
            },
            server = {
              on_attach = require("config.utils.lsp").setup,
              standalone = false,
            },
          }
        end,
      },

      {
        "stevearc/conform.nvim",
        config = function()
          require("conform").setup({
            formatters_by_ft = {
              python = { "autopep8" },
              sh = { "shfmt" },
              javascript = { "prettierd" },
              typescript = { "prettierd" },
              html = { "prettierd" },
              css = { "prettierd" },
              json = { "prettierd" },
              yaml = { "prettierd" },
              markdown = { "prettierd" },
              lua = { "stylua" },
              c = { "clang_format" },
              cpp = { "clang_format" },
              toml = { "taplo" },
            },
            format_on_save = {
              timeout_ms = 500,
              lsp_fallback = true,
            },
            formatters = {
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
                      "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}",
                    }
                  end
                  return {}
                end,
              },
            },
          })
        end,
      },

      {
        "j-hui/fidget.nvim",
        opts = { window = { blend = 0 } },
        branch = "legacy",
      },
    },
  },
}
