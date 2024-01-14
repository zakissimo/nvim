local servers = require("mason-lspconfig").get_installed_servers()

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local mason_lspconfig = require("mason-lspconfig")

local on_attach = function(_, bufnr)
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
    vim.keymap.set("n", "<C-f>", function()
        vim.lsp.buf.format()
    end, opts)
end

require("mason").setup()
mason_lspconfig.setup({})

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

mason_lspconfig.setup_handlers({
    function(server_name)
        if server_name ~= 'rust_analyzer' then
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                handlers = handlers,
                on_attach = on_attach,
                settings = servers[server_name],
            })
        end
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
