M = {}

M.on_attach = function(event)
  local map = function(keys, func)
    vim.keymap.set("n", keys, func, { buffer = event.buf })
  end

  map("gd", vim.lsp.buf.definition)
  map("gr", vim.lsp.buf.references)
  map("gh", vim.diagnostic.open_float)
  map("gh", function()
    vim.diagnostic.open_float({
      close_events = { "CursorMoved", "InsertEnter" },
      border = "rounded",
    })
  end)

  map("<leader>r", vim.lsp.buf.rename)
  map("<leader>c", vim.lsp.buf.code_action)
  map("<leader>q", vim.diagnostic.setloclist)

  map("<leader>k", vim.lsp.buf.signature_help)
  map("K", function()
    vim.lsp.buf.hover({
      close_events = { "CursorMoved", "InsertEnter" },
      border = "rounded",
    })
  end)

  map("<leader>el", "<CMD>Telescope diagnostics<CR>")

  if vim.lsp.inlay_hint then
    map("<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)
  end
end

M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
end

M.servers = function()
  return {
    sourcekit = {
      filetypes = { "swift" },
    },
    qmlls = {
      cmd = { "qmlls6" },
      filetypes = { "qml", "qmljs" },
      root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find({ ".git", ".qmlls.ini", "." }, { path = fname, upward = true })[1])
      end,
      single_file_support = true,
    },
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
  }
end

return M
