-- file executing
local alias = require('mappings/alias')

file_obj = {
    { filetype = 'python', cmd = { 'python' } },
    { filetype = 'javascript', cmd = { 'node' } },
    { filetype = 'typescript', cmd = { 'npx', 'ts-node' } },
    { filetype = 'go', cmd = { 'go', 'run' } },
    { filetype = 'sh', cmd = { 'sh', '-c' } },
    { filetype = 'rust', cmd = { 'rustc', '-o', '/var/tmp/single_rust' }, after_cmd = { '&&', '/var/tmp/single_rust', ';', 'rm', '-f', '/var/tmp/single_rust' } },
}

function run_file()
    for _, obj in pairs(file_obj) do
        if vim.bo.filetype == obj.filetype then
            vim.cmd('write!')
            local filepath = vim.fn.expand('%')
            vim.cmd.vnew()
            vim.cmd.terminal()
            local cmd = table.concat(obj.cmd, ' ') .. ' ' .. filepath
            if obj.after_cmd then
                cmd = cmd .. table.concat(obj.after_cmd, ' ')
            end
            cmd = cmd .. '\r'
            vim.api.nvim_chan_send(vim.bo.channel, cmd)
        end
    end
end

alias.map('<F9>', run_file, { buffer = true })

local file_fmt = {
    { filetype = 'go', cmd = { 'gofmt' } },
    { filetype = 'rust', cmd = { 'rustfmt' } },
}

function format_file()
    for _, obj in pairs(file_fmt) do
        if vim.bo.filetype == obj.filetype then
            local cmd = table.concat(obj.cmd, ' ') .. ' '
            vim.cmd('%!' .. cmd)
            vim.cmd('write!')
        end
    end
end

alias.map('<F10>', format_file, { buffer = true })

function close_term()
    vim.cmd.startinsert()
    local stop = vim.api.nvim_replace_termcodes('<C-c>', true, false, true)
    vim.api.nvim_feedkeys(stop, 't', false)
    local exit = vim.api.nvim_replace_termcodes('<C-d>', true, false, true)
    vim.api.nvim_feedkeys(exit, 't', true)
end

vim.api.nvim_create_autocmd(
    { 'TermOpen' },
    {
        pattern = {'*'},
        callback = function()
            alias.map('<F9>', close_term, { buffer = true })
        end,
    }
)
vim.api.nvim_create_autocmd(
    { 'TermClose' },
    {
        pattern = {'*'},
        callback = function()
            vim.cmd(':bd')
        end,
    }
)

