local export = {}

export.ensure_installed = {
    'pylsp',
    -- 'gopls', -- fails with error
    'ts_ls',
    'dockerls',
    'rust_analyzer',
    'lua_ls',
    'html',
    'yamlls',
}

return export
