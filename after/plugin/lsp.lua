local on_attach = require("zak.utils").on_attach

local sg_ok, sg = pcall(require, "sg")
if sg_ok then
    sg.setup({ require("zak.utils").on_attach })
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = on_attach,
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
    clangd = {
        cmd = {
            "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--compile_args_from=filesystem",
            "--completion-parse=always",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--debug-origin",
            "--enable-config",
            "--fallback-style=Qt",
            "--folding-ranges",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
            "--log=error",
            "--pch-storage=memory",
            "--suggest-missing-includes",
            "-j=12",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = function(fname)
            local root_files = {
                ".clangd",
                ".clang-tidy",
                ".clang-format",
                "compile_commands.json",
                "compile_flags.txt",
                "build.sh",
                "configure.ac",
                "run",
                "compile",
            }
            return require("lspconfig.util").root_pattern(unpack(root_files))(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
        end,
        single_file_support = true,
        commands = {},
    },
}

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

mason.setup({
    PATH = "append",
})

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
