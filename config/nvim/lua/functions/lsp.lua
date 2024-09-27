local export = {}

function export.on_attach(client, bufnr)
    require('mappings/plugins').lsp()
end

function export.setup_ui()
    vim.diagnostic.config({
        require('settings/lsp').ui
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

