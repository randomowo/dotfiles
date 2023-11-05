local opt = vim.opt
local globals = vim.g

vim.cmd('filetype on')
vim.cmd('filetype indent on')
vim.cmd('filetype plugin on')

opt.relativenumber = true
opt.linebreak = true
opt.wrapmargin = 0
opt.textwidth = 0
opt.colorcolumn = '+120'
opt.fileformat = 'unix'
opt.encoding = 'utf-8'
opt.cmdheight = 1
opt.shortmess:append 'c'
opt.path:append '*/*'
opt.hlsearch = true
opt.smartcase = true
opt.incsearch = true
opt.cindent = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.secure = true
opt.ruler = true
opt.list = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
vim.cmd('set nopaste')
opt.mouse = ''
opt.syntax = 'on'

globals.compeleteopt = 'menu,menuone,noselect'
globals.showmode = 'off'


-- highlight extra whitespace at the end
vim.cmd.highlight({ 'TrailingWhitespaces', 'ctermbg=red', 'guibg=red' })
vim.api.nvim_create_autocmd(
    { 'BufNew', 'BufEnter', 'BufWinEnter', 'WinEnter' },
    {
        pattern = {'*'},
        command = 'match TrailingWhitespaces /\\s\\+$/',
    }
)

