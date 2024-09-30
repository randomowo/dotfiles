local export = {}

function export.install_required(plug)
    local r = require('mason-registry')
    if not r.is_installed('codelldb') then
        vim.cmd('MasonInstall codelldb')
    end
end

return export
