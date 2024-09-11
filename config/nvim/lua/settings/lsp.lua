local export = {
    configs = {
        { name = 'pylsp', settings = {} },--, preload_cmd = { 'npm', 'i', '-g', 'pyright' } },
        { name = 'gopls', settings = {}, preload_cmd = { 'go', 'install', 'golang.org/x/tools/gopls@latest' } },
        { name = 'ts_ls', settings = {} }, -- preload_cmd = { 'npm', 'i', '-g', 'typescript-language-server' } },
        { name = 'dockerls', settings = {}, preload_cmd = { 'npm', 'i', '-g', 'dockerfile-language-server-nodejs' } },
        { name = 'rust_analyzer', settings = {}, preload_cmd = { 'rustup', 'component', 'add', 'rust-analyzer' } },
    }
}

return export

