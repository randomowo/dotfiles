local export = {
    configs = {
        {
            name = 'pylsp',
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
            settings = {},
        },
        {
            name = 'ts_ls',
            settings = {},
        },
        {
            name = 'dockerls',
            settings = {},
        },
        {
            name = 'rust_analyzer',
            settings = {},
        },
        {
            name = 'lua_ls',
            settings = {},
        },
    },
}

return export
