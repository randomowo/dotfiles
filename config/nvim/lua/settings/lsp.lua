local export = {}

export.configs = {
    {
        name = 'pylsp',
        cmd = {},
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        enabled = false,
                    },
                    mccabe = {
                        enabled = false,
                    },
                    pyflakes = {
                        enabled = false,
                    },
                    flake8 = {
                        enabled = true,
                    },
                },
                configurationSources = {
                    'flake8',
                },
            },
        },
    },
    {
        name = 'gopls',
        cmd = {},
        settings = {},
    },
    {
        name = 'ts_ls',
        cmd = {},
        settings = {},
    },
    {
        name = 'dockerls',
        cmd = {},
        settings = {},
    },
    {
        name = 'rust_analyzer',
        cmd = {},
        settings = {},
    },
    {
        name = 'lua_ls',
        cmd = {},
        settings = {},
    },
    {
        name = 'html',
        cmd = {},
        settings = {
            filetypes = { 'html' },
            init_options = {
                configurationSection = { 'html', 'css' },
                embeddedLanguages = {
                    css = true,
                },
            },
        },
    },
}

local utils = require('functions/utils')

if pcall(require, 'settings/custom_lsp') then
    local custom_settings = require('settings/custom_lsp') or { configs = {} }
    export.configs = utils.mergeListsByKey(export.configs, custom_settings.configs or {}, 'name')
end

export.ui = {
    virtual_text = true,
}

return export
