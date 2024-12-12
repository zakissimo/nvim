M = {}

M.setup_binds = function(event)
  local map = function(keys, func)
    vim.keymap.set("n", keys, func, { buffer = event.buf })
  end

  map("gd", "<CMD>Telescope lsp_definitions<CR>")
  map("gr", "<CMD>Telescope lsp_references<CR>")
  map("gh", vim.diagnostic.open_float)

  map("<leader>r", vim.lsp.buf.rename)
  map("<leader>c", vim.lsp.buf.code_action)
  map("<leader>q", vim.diagnostic.setloclist)

  map("K", vim.lsp.buf.hover)
  map("<leader>k", vim.lsp.buf.signature_help)

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

M.get_server = function(server_name)
  local servers = {
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
  return servers[server_name]
end

return M
