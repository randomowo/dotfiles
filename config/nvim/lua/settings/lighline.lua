local export = {
    opts = {
        colorscheme = 'gruvbox',
        active = {
            left = {
                { 'mode', 'paste' },
                { 'buffers' },
            },
            right = {
                { 'lineifno' },
                { 'readonly' },
                { 'fileencoding', 'filetype' },
                { 'gitbranch' },
            },
        },
        tabline = {
            left = {
                { 'tabs' },
            },
            right = {},
        },
        component_type = {
            buffers = { 'raw' },
        },
        component_expant = {
            buffers = function() vim.cmd('bufferline#refresh_status().bufferline#get_status_string') end,
        },
        compontn_function = {
            gitbranch = require('../functions/git').current_branch,
        },
    }
}

return export

