local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local auto_format = function(bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        auto_format(bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<C-f>", function()
            vim.lsp.buf.format()
        end, opts)
    end
end

null_ls.setup({
    debug = true,

    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({
            condition = function(utils)
                return utils.root_has_file(".clang-format")
            end,
        }),
        formatting.clang_format.with({
            extra_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" },
            condition = function(utils)
                return not utils.root_has_file(".clang-format")
            end,
        }),
        formatting.prettierd,
        diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc.js" })
            end,
        }),
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
        code_actions.eslint_d,
    },
    on_attach = on_attach,
})
