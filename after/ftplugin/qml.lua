vim.lsp.config('qmlls', {
  cmd = { "qmlls6" },
  single_file_support = true,
})

vim.lsp.enable('qmlls')
