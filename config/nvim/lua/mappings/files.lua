-- file executing
local alias = require('mappings/alias')

file_obj = {
    { filetype = 'python', cmd = { 'python' } },
    { filetype = 'javascript', cmd = { 'node' } },
    { filetype = 'typescript', cmd = { 'npx', 'ts-node' } },
    { filetype = 'go', cmd = { 'go', 'run' } },
    { filetype = 'sh', cmd = { 'sh', '-c' } },
}

function run_file()
    for _, obj in pairs(file_obj) do
        if vim.bo.filetype == obj.filetype then
            vim.cmd('write!')
            local filepath = vim.fn.expand('%')
            vim.cmd.wincmd('v')
            vim.cmd.terminal()
            vim.api.nvim_chan_send(vim.bo.channel, table.concat(obj.cmd, ' ') .. ' ' .. filepath ..'\r')
        end
    end
end

alias.map('<F9>', run_file, { buffer = true })

