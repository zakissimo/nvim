local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

mason.setup()
mason_lspconfig.setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local on_attach = function(_, bufnr)
    local map = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = bufnr })
    end

    map("gd", "<CMD>FzfLua lsp_definitions<CR>")
    map("gD", "<CMD>FzfLua lsp_declarations<CR>")
    map("gi", "<CMD>FzfLua lsp_implementations<CR>")
    map("gt", "<CMD>FzfLua lsp_typedefs<CR>")
    map("gr", "<CMD>FzfLua lsp_references<CR>")
    map("<leader>el", "<CMD>FzfLua lsp_document_diagnostics<CR>")
    map("<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>")

    map("K", vim.lsp.buf.hover)
    map("gh", vim.diagnostic.open_float)
    map("<leader>rn", vim.lsp.buf.rename)
    map("<leader>q", vim.diagnostic.setloclist)
    map("<leader>ek", vim.diagnostic.goto_prev)
    map("<leader>ej", vim.diagnostic.goto_next)
    map("<leader>k", vim.lsp.buf.signature_help)

    if vim.lsp.inlay_hint then
        map("<leader>ih", function()
            vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
        end)
    end
end

local servers = {
    rust_analyzer = {
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
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
}

mason_lspconfig.setup_handlers({
    function(server_name)
        local server = servers[server_name] or {}
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = server.settings,
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
