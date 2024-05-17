local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
    return
end

lint.linters_by_ft = {
    cpp = { "cpplint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})
