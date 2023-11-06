local export = {
    configs = {
        { name = 'pyright', settings = {}, preload_cmd = { 'npm', 'i', '-g', 'pyright' } },
        { name = 'gopls', settings = {}, preload_cmd = { 'go', 'install', 'golang.org/x/tools/gopls@latest' } },
        { name = 'tsserver', settings = {}, preload_cmd = { 'npm', 'i', '-g', 'typescript-language-server' } },
        { name = 'dockerls', settings = {}, preload_cmd = { 'npm', 'i', '-g', 'dockerfile-language-server-nodejs'} },
    }
}

return export

