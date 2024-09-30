local export = {}

local map_key = vim.keymap.set

function export.map(key, command, opts, mode)
    opts = opts or {}
    opts.noremap = true
    opts.silent = opts.silent or false

    map_key(mode or '', key, command, opts)
end

function export.normal_map(key, command, opts)
    export.map(key, command, opts, 'n')
end

function export.insert_map(key, command, opts)
    export.map(key, command, opts, 'i')
end

function export.visual_map(key, command, opts)
    export.map(key, command, opts, 'v')
end

function export.terminal_map(key, command, opts)
    export.map(key, command, opts, 't')
end

return export
