require("config.lazy")

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = vim.api.nvim_create_augroup("YankHl", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = require("config.utils.lsp").setup_binds,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "none",
    source = true,
    header = "",
    prefix = "",
  },
})
