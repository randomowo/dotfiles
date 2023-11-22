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
            'gitignore',
        },
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    }
}

return export

