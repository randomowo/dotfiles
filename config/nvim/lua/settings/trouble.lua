local export = {}

export.opts = {
    win = {
        size = {
            width = 0.4,
            height = 0.4,
        }
    },
    modes = {
        diagnostics = {
            mode = 'diagnostics', -- inherit from diagnostics mode
            filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
    }
}

return export
