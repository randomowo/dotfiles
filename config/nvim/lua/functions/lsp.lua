local export = {}

local utils = require('functions/utils')

function export.on_attach(client, bufnr)
    utils.import('mappings/plugins').lsp()
end

function export.setup_ui()
    vim.diagnostic.config({
        utils.import('settings/lsp').ui
    })

    vim.o.updatetime = 250
    -- vim.api.nvim_create_autocmd(
    --     { 'CursorHold', 'CursorHoldI' },
    --     {
    --         pattern = '*',
    --         command = 'lua vim.diagnostic.open_float(nil, {focus=false})',
    --     }
    -- )
end

return export

