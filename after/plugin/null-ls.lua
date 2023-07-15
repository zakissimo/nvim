local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,

    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({
            extra_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" },
        }),
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
