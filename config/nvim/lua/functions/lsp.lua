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
end

return export
