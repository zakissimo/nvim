local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
    return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return coroutine.create(function(coro)
                local opts = {}
                pickers
                    .new(opts, {
                        prompt_title = "Path to executable",
                        finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                        sorter = conf.generic_sorter(opts),
                        attach_mappings = function(buffer_number)
                            actions.select_default:replace(function()
                                actions.close(buffer_number)
                                coroutine.resume(coro, action_state.get_selected_entry()[1])
                            end)
                            return true
                        end,
                    })
                    :find()
            end)
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        initCommands = function()
            local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

            local commands = {}
            local file = io.open(commands_file, "r")
            if file then
                for line in file:lines() do
                    table.insert(commands, line)
                end
                file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
        end,
    },
}

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
    return
end

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

local map = function(keys, func)
    vim.keymap.set("n", keys, func)
end

map("<Leader>dt", dapui.toggle)

map("<Leader>do", dap.continue)
map("<Leader>dn", dap.step_into)
map("<Leader>dp", dap.step_out)
map("<Leader>ds", dap.step_over)
map("<Leader>db", dap.toggle_breakpoint)
map("<Leader>dr", dap.repl.toggle)

-- vim.keymap.set("n", "<Leader>dl", function()
--     require("dap").run_last()
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
--     require("dap.ui.widgets").hover()
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
--     require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
--     local widgets = require("dap.ui.widgets")
--     widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
--     local widgets = require("dap.ui.widgets")
--     widgets.centered_float(widgets.scopes)
-- end)

dapui.setup()
