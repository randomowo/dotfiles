local export = {}

function export.setup()
    local globals = vim.g

    globals.gitgutter_highlight_linenrs = true
    globals.gitgutter_preview_win_floating = true
end

return export
