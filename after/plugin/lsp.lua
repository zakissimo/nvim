require("neodev").setup({})
local lsp = require("lsp-zero")
lsp.preset("recommended")

local servers = require'mason-lspconfig'.get_installed_servers()

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = false,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = false,
    call_servers = "local",
    sign_icons = {
        error = "",
        warn = "",
        hint = "",
        info = "",
    },
})

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", opts)
    vim.keymap.set("n", "gi", "<CMD>FzfLua lsp_implementations<CR>", opts)
    vim.keymap.set("n", "gt", "<CMD>FzfLua lsp_typedefs<CR>", opts)
    vim.keymap.set("n", "gr", "<CMD>FzfLua lsp_references<CR>", opts)
    vim.keymap.set("n", "<leader>rn", "<CMD>FzfLua lsp_rename<CR>", opts)
    vim.keymap.set("n", "<leader>el", "<CMD>FzfLua lsp_document_diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", opts)

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setloclist()
    end, opts)
    vim.keymap.set("n", "<leader>ek", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>ej", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "<leader>k", function()
        vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "gh", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<F2>", function()
        vim.lsp.buf.format()
    end, opts)
end

lsp.on_attach(on_attach)

lsp.setup()

local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
    ["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local lspkind = require("lspkind")
local cmp_config = lsp.defaults.cmp_config({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        col_offset = -3,
        side_padding = 0,
    },
    mapping = cmp_mappings,
    formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" } })(
                entry,
                vim_item
            )
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = ""
            return kind
        end,
    },
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp", max_item_count = 7 },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip", max_item_count = 5 },
        { name = "path" },
    }),
})

cmp.setup(cmp_config)

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
        local format_cmd = function(input)
            vim.lsp.buf.format({
                id = client.id,
                timeout_ms = 5000,
                async = input.bang,
            })
        end

        local bufcmd = vim.api.nvim_buf_create_user_command
        bufcmd(bufnr, "NullFormat", format_cmd, {
            bang = true,
            range = true,
            desc = "Format using null-ls",
        })
    end,
    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({ extra_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" } }),
        formatting.prettierd.with({ filetypes = { "markdown", "css", "html" } }),
        formatting.deno_fmt.with({ extra_args = { "--options-single-quote", "--options-indent-width=4" } }),
        diagnostics.shellcheck,
        diagnostics.pylint.with({
            extra_args = {
                "--disable=C0111",
                "--disable=C0103",
                "--disable=F0401",
                "--disable=R0903",
                "--disable=R0904",
                "--disable=W0231",
                "--disable=W0611",
                "--disable=W0612",
                "--disable=W0613",
                "--disable=W0614",
            },
        }),
        code_actions.eslint,
    },
})

require("mason-null-ls").setup({
    ensure_installed = {},
    automatic_installation = true,
    automatic_setup = true,
})

-- Required when `automatic_setup` is true
require("mason-null-ls").setup_handlers({})
