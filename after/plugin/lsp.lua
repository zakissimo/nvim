local _ = require("mason-lspconfig").get_installed_servers()

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local mason_lspconfig = require("mason-lspconfig")

local function is_null_ls_ft(curr, null_ls_fts)
    for _, ft in ipairs(curr) do
        if vim.list_contains(null_ls_fts, ft) then
            return true
        end
    end
    return false
end

local function get_null_ls_fts()
    local null_ls_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_ok then
        return
    end
    local fts = {}
    for _, ft_tbl in pairs(null_ls.builtins.formatting) do
        for _, ft in ipairs(ft_tbl.filetypes) do
            table.insert(fts, ft)
        end
    end
    return fts
end

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", opts)
    vim.keymap.set("n", "gi", "<CMD>FzfLua lsp_implementations<CR>", opts)
    vim.keymap.set("n", "gt", "<CMD>FzfLua lsp_typedefs<CR>", opts)
    vim.keymap.set("n", "gr", "<CMD>FzfLua lsp_references<CR>", opts)
    vim.keymap.set("n", "<leader>el", "<CMD>FzfLua lsp_document_diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", opts)

    vim.keymap.set("n", "<leader>rn", function()
        vim.lsp.buf.rename()
    end, opts)
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

    if vim.lsp.inlay_hint then
        vim.keymap.set("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
        end, opts)
    end

    -- If a filetype is handled by null-ls let it handle formatting
    local null_ls_fts = get_null_ls_fts()
    if is_null_ls_ft(client.config.filetypes, null_ls_fts) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<C-f>", function()
            vim.lsp.buf.format()
        end, opts)
    end
end

require("mason").setup()
mason_lspconfig.setup({})

mason_lspconfig.setup_handlers({
    function(server_name)
        local settings = {}
        if server_name == "rust_analyzer" then
            settings = {
                ["rust-analyzer"] = {
                    lens = {
                        enable = true,
                    },
                    checkOnSave = {
                        enable = true,
                        command = "clippy",
                    },
                },
            }
        end
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = settings,
        })
    end,
})

if pcall(require, "sg") then
    require("sg").setup({
        on_attach = on_attach,
    })
end

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
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

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "", linehl = "" })
end

require("mason-null-ls").setup({
    ensure_installed = { "shfmt", "stylua", "autopep8", "clang_format", "prettierd", "eslint_d", "pylint" },
    automatic_installation = true,
    automatic_setup = true,
})
