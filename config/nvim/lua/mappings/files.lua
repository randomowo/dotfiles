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
            vim.cmd('exec \'!' .. table.concat(obj.cmd, ' ') .. '\' shellescape(@%, 1)')
        end
    end
end

alias.map('<F9>', run_file, { buffer = true })

