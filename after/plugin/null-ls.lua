local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<F2>", function()
        vim.lsp.buf.format()
    end, opts)
end

null_ls.setup({
    debug = true,

    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({
            extra_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" },
        }),
        formatting.prettierd.with({ filetypes = { "markdown", "css", "html" } }),
        formatting.deno_fmt.with({ extra_args = { "--options-single-quote", "--options-indent-width=4" } }),
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
