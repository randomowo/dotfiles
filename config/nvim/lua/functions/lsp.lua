local export = {}

function export.on_attach(client, bufnr)
    require('mappings/plugins').lsp()
end

return export

