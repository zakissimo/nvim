local conform_ok, conform = pcall(require, "conform")
if not conform_ok then
    return
end

conform.setup({
    formatters_by_ft = {
        python = { "autopep8" },
        sh = { "shfmt" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters = {
        shfmt = {
            prepend_args = { "--indent", "4" },
        },
        stylua = {
            prepend_args = { "--indent-type", "Spaces" },
        },
        clang_format = {
            prepend_args = function(_, _)
                local format_files = vim.fs.find(".clang-format", { upward = true, stop = vim.fn.expand("$HOME") })
                if #format_files == 0 then
                    return { "-style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never, PointerAlignment: Left}" }
                end
                return {}
            end,
        },
    },
})
