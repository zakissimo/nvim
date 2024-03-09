vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func)
            vim.keymap.set("n", keys, func, { buffer = event.buf })
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
                vim.lsp.inlay_hint.enable(event.buf, not vim.lsp.inlay_hint.is_enabled())
            end)
        end
    end,
})

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

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

mason.setup()

local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_ok then
    return
end

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua",
})
mason_tool_installer.setup({ ensure_installed = ensure_installed })

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

mason_lspconfig.setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.handlers = handlers
            require("lspconfig")[server_name].setup(server)
        end,
    },
})

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
