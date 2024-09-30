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
}

export.ui = {
    virtual_text = true,
}

return export
