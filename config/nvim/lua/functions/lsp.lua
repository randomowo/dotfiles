local export = {}

function export.on_attach(client, bufnr)
    require('../mapping/plugins').lsp()
end

return export

