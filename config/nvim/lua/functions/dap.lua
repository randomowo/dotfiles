local export = {}

function export.add_listeners_for_ui(dap, dapui)
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
end

function export.setup_codelldb(dap)
    local port = 13000

    dap.adapters.codelldb = {
        type = 'server',
        port = port,
        executable = {
            command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
            args = { '--port', port },
        },
    }

    dap.configurations.c = {
        {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c
end

return export
