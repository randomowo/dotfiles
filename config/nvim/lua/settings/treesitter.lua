local export = {
    opts = {
        ensure_installed = {
            'c',
            'bash',
            'vim',
            'vimdoc',
            'lua',
            'rust',
            'go',
            'python',
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
}

return export

