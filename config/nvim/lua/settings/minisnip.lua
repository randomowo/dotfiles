local export = {}

function export.setup()
    local globals = vim.g

    globals.minisnip_trigger = '<S-Tab>'
    globals.minisnip_dir = vim.fn.stdpath('config') .. 'data/minisnip'
end

return export

