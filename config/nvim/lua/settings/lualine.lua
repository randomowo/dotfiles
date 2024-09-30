local export = {
    opts = {
        options = {
            icons_enabled = true,
            theme = 'gruvbox',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            -- left
            lualine_a = { 'mode', 'paste' },
            lualine_b = { 'buffers' },
            lualine_c = {},

            -- right
            lualine_x = { 'location', 'progress' },
            lualine_y = { 'encoding', 'filetype' },
            lualine_z = { 'branch' }
        },
        inactive_sections = {},
        tabline = {
            -- left
            lualine_a = { 'tabs' },
            lualine_b = {},
            lualine_c = {},

            -- right
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
}

return export
