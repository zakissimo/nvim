M = {}

M.on_attach = function(event)
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
end

return M
