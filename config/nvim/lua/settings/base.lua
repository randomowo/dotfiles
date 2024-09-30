local opt = vim.opt
local globals = vim.g

vim.cmd('filetype plugin indent on')

opt.number = true
opt.relativenumber = false
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
opt.listchars = { trail = '-', lead = '-', tab = '> ' }
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
vim.cmd('set nopaste')
opt.mouse = ''
opt.syntax = 'on'

-- fold settings
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- treesitter required
opt.foldcolumn = '0'
opt.foldtext = ''
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4
--

globals.compeleteopt = 'menu,menuone,noselect'
globals.showmode = 'off'
globals.mapleader = ' '

--

local utils = require('functions/utils')

local functions = utils.import('functions/globals')

-- make background transparent
vim.cmd('hi! Normal ctermbg=NONE guibg=NONE')

-- highlight extra whitespace at the end
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
vim.api.nvim_create_autocmd(
    { 'ColorScheme' },
    {
        pattern = { '*' },
        command = 'highlight ExtraWhitespace ctermbg=red guibg=red',
    }
)
vim.api.nvim_create_autocmd(
    { 'BufNew', 'BufEnter', 'BufWinEnter', 'WinEnter' },
    {
        pattern = { '*' },
        command = 'match ExtraWhitespace /\\s\\+$/',
    }
)

-- on save file actions
vim.api.nvim_create_autocmd(
    { 'BufWritePre', 'FileWritePre' },
    {
        pattern = { '*' },
        callback = function()
            -- trim trailing whitespaces
            functions.trim_whitespaces()
            -- fix tabs and spaces
            vim.cmd('retab!')
            -- make files ends with one new line
            -- functions.fix_newlines_at_eof()
        end,
    }
)

utils.import('settings/files')
