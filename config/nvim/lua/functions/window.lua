local export = {}

function export.move(key)
    local current_window = vim.fn.winnr()
    vim.cmd.wincmd(key)
    if current_window == vim.fn.winnr() then
        if key == 'j' or key == 'k' then
            vim.cmd.new()
        else
            vim.cmd.vnew()
        end
    end
end

return export

