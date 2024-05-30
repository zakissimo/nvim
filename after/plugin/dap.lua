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
        initCommands = function()
            return {
                string.format("command script import %s/formatters/qtlldb/QtFormatters.py", vim.fn.stdpath("config")),
                string.format("command source %s/formatters/qtlldb/QtFormatters.lldb", vim.fn.stdpath("config")),
            }
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

local function get_cmd(s)
    return coroutine.create(function(coro)
        local args = {}
        vim.ui.input({ prompt = s .. ": ", completion = "file" }, function(input)
            if input ~= nil then
                args = vim.split(input, " ")
                coroutine.resume(coro, args[1])
            end
        end)
    end)
end

local map = function(keys, func)
    vim.keymap.set("n", keys, func)
end

map("<Leader>dt", dapui.toggle)
map("<Leader>b", dap.run_to_cursor)
map("<Leader>db", dap.toggle_breakpoint)

map("<F5>", function()
    local program = get_cmd("Program")
    local args = get_cmd("Arguments")
    dap.run({
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = program,
        args = { args },
    })
end)

map("<F6>", dap.continue)
map("<F7>", dap.step_into)
map("<F8>", dap.step_over)
map("<F9>", dap.step_out)
map("<F10>", dap.step_back)
map("<F11>", dap.restart)

dapui.setup()
