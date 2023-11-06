local export = {}

function export.setup()
    local globals = vim.g

    globals.bufferline_echo = false
    globals.bufferline_show_bufnr = false
    globals.bufferline_pathshorten = true
    globals.bufferline_active_buffer_left = ''
    globals.bufferline_active_buffer_right = ''
    globals.bufferline_modified = '*'
    globals.bufferline_unnamed = '[No Name]'
    globals.bufferline_separator = ' '
    globals.bufferline_solo_highlight = true
end

return export

