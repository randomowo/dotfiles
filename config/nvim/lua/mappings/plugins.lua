local export = {}

local utils = require('functions/utils')
local alias = utils.import('mappings/alias')

function export.nerdtree(plug)
    alias.map('<F3>', '<cmd>NERDTreeToggle<cr>')
    alias.map('<F15>', '<cmd>NERDTreeFind<cr>')
    alias.map('<S-F3>', '<cmd>NERDTreeFind<cr>')
end

function export.tagbar()
    alias.map('<F8>', '<cmd>TagbarToggle<cr>')
end

function export.gitgutter(plug)
    -- TODO
end

function export.cmp(plug)
    return {
        ['<F2>'] = plug.mapping.select_next_item({ behavior = plug.SelectBehavior.Select }),
        ['<F14>'] = plug.mapping.select_prev_item({ behavior = plug.SelectBehavior.Select }),
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
    alias.normal_map('U', vim.lsp.buf.references, opts)
    alias.normal_map('gi', vim.lsp.buf.implementation, opts)
    alias.normal_map('<leader>D', vim.lsp.buf.type_definition, opts)
    alias.normal_map('<leader>rn', vim.lsp.buf.rename, opts)
    alias.normal_map('<leader>ca', vim.lsp.buf.code_action, opts)
    alias.normal_map('<leader>e', vim.diagnostic.open_float, opts)
    alias.normal_map('[d', vim.diagnostic.goto_prev, opts)
    alias.normal_map(']d', vim.diagnostic.goto_next, opts)
    alias.normal_map('<leader>q', vim.diagnostic.setloclist, opts)
    alias.normal_map('<leader>F', vim.lsp.buf.format, opts)
end

function export.telescope(plug)
    alias.normal_map('<leader>ff', '<cmd>Telescope find_files<cr>')
    alias.normal_map('<leader>fg', '<cmd>Telescope live_grep<cr>')
    alias.normal_map('<leader>fb', '<cmd>Telescope buffers<cr>')
    alias.normal_map('<leader>fh', '<cmd>Telescope help_tags<cr>')
end

function export.dap(plug)
    alias.normal_map('<F21>', plug.continue)
    alias.normal_map('<F20>', plug.step_over)
    alias.normal_map('<F19>', plug.step_into)
    alias.normal_map('<leader>b', plug.toggle_breakpoint)
end

function export.todo_comments(plug)
    alias.normal_map('<leader>ft', '<cmd>TodoTelescope<cr>')
end

function export.trouble(plug)
    local settings = utils.import('settings/trouble')
    alias.normal_map('<leader>t', '<cmd>Trouble diagnostics toggle focus=true<cr>')
end

function export.formatter(plug)
    alias.normal_map('<leader>f', '<cmd>:Format<cr>')
    alias.normal_map('<leader>F', '<cmd>:FormatWrite<cr>')
end

return export
