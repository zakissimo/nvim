M = {}

M.setup = function(event)
  local map = function(keys, func)
    vim.keymap.set("n", keys, func, { buffer = event.buf })
  end

  map("gd", vim.lsp.buf.definition)
  map("gr", vim.lsp.buf.references)
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

M.get_system_servers = function()
  return {
    sourcekit = {
      filetypes = { "swift" },
    },
  }
end

M.get_mason_server = function(server_name)
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
