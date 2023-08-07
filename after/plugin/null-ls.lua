local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function clang_file_present()
    local get_root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git")
    local root_dir = get_root_dir(vim.fn.getcwd())
    local clang_format_file = root_dir .. '/.clang-format'

    return vim.fn.filereadable(clang_format_file) == 1
end

null_ls.setup({
    debug = false,

    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({
            extra_args = clang_file_present() and {} or { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" },
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
