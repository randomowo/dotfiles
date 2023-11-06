-- yaml
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = { '*.yaml', '*.yml' },
        command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab'
    }
)

-- golang
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = { '*.go' },
        command = 'setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab'
    }
)
