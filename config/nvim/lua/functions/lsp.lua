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

function export.setup(plug)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local settings = require('settings/lsp')

    for _, server in pairs(settings.configs) do
        plug[server.name].setup {
            settings = server.settings,
            root_dir = server.root_dir,
            on_attach = export.on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end
end

return export
