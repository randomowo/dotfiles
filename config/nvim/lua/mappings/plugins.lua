local export = {}

local alias = require('mappings/alias')

function export.nerdtree(plug)
    alias.map('<F3>', '<cmd>NERDTreeToggle<cr>')
    alias.map('<F15>', '<cmd>NERDTreeFind<cr>')
end

function export.tagbar(plug)
    alias.normal_map('<F8>', '<cmd>TagbarToggle<cr>')
end

function export.gitgutter(plug)
    -- TODO
end

function export.cmp(plug)
    return {
        ['<F2>'] = plug.mapping.select_next_item({ behavior = plug.SelectBehavior.Select }),
        ['<C-d>'] = plug.mapping.scroll_docs(-4),
        ['<C-f>'] = plug.mapping.scroll_docs(4),
        ['<C-a>'] = plug.mapping.complete(),
        --['<Esc>'] = cmp.mapping.close(),
        ['<Tab>'] = plug.mapping.confirm({ select = true }),
    }
end

function export.lsp(plug)
    local opts = { silent = true }
    alias.normal_map('gD', vim.lsp.buf.declaration, opts)
    alias.normal_map('gd', vim.lsp.buf.definition, opts)
    alias.normal_map('K', vim.lsp.buf.hover, opts)
    alias.normal_map('gi', vim.lsp.buf.implementation, opts)
    alias.normal_map('<space>D', vim.lsp.buf.type_definition, opts)
    alias.normal_map('<space>rn', vim.lsp.buf.rename, opts)
    alias.normal_map('<space>ca', vim.lsp.buf.code_action, opts)
    alias.normal_map('<space>e', vim.diagnostic.open_float, opts)
    alias.normal_map('[d', vim.diagnostic.goto_prev, opts)
    alias.normal_map(']d', vim.diagnostic.goto_next, opts)
    alias.normal_map('<space>q', vim.diagnostic.setloclist, opts)
    alias.normal_map('<space>f', vim.lsp.buf.format, opts)
end

return export

