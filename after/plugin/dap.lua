local dap, dapui = require("dap"), require("dapui")

dap.adapters.rustgdb = {
  name = "rustgdb",
  type = "executable",
  command = "rust-gdb",
  args = { "--quiet", "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.rust = {
  {
    type = "rustgdb",
    name = "Launch debug binary",
    request = "launch",
    program = function()
      local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
      local metadata = vim.fn.json_decode(metadata_json)
      local target_name = metadata.packages[1].targets[1].name
      local target_dir = metadata.target_directory
      return target_dir .. "/debug/" .. target_name
    end,
    args = function()
      local inputstr = vim.fn.input("Params: ", "")
      local params = {}
      local sep = "%s"
      for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(params, str)
      end
      return params
    end,
  },
}

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

vim.keymap.set("n", "<leader>d", dapui.toggle)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
