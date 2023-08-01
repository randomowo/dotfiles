-- by randomowo

local cmp = require 'cmp'

cmp.setup({
    mapping = {
        ['<F2>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-a>'] = cmp.mapping.complete(),
        --['<Esc>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    },
    {
        { name = 'buffer' },
    })
})

