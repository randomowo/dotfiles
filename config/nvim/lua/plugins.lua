-- install packer if not installer
local lazypath = vim.fn.stdpath('config') .. 'data/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local utils = require('functions/utils')
local mappings = utils.import('mappings/plugins')

-- plugins
require('lazy').setup({
    -- colortheme
    {
        'morhetz/gruvbox',
        init = function(...)
            vim.cmd('colorscheme gruvbox')
        end,
    },
    -- highlight similars
    'RRethy/vim-illuminate',
    -- better highlighting
    'sheerun/vim-polyglot',
    -- visual
    'ap/vim-css-color',
    {
        'nvim-treesitter/nvim-treesitter',
        init = function()
            require('nvim-treesitter.configs').setup(
                utils.import('settings/treesitter').opts
            )
        end,
    },
    -- right order is:
    -- 1. mason
    -- 2. mason-lspconfig
    -- 3. lspconfig
    {
        'williamboman/mason.nvim',
        init = function()
            local plug = require('mason')
            plug.setup()
            utils.import('functions/mason').install_required(plug)
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        init = function()
            local plug = require('mason-lspconfig')
            plug.setup()
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-nvim-lsp-signature-help',
                    'L3MON4D3/LuaSnip',
                    'saadparwaiz1/cmp_luasnip'
                },
                init = function()
                    local plug = require('cmp')
                    plug.setup({
                        snippet = {
                            expand = function(args)
                                require('luasnip').lsp_expand(args.body)
                            end,
                        },
                        mapping = mappings.cmp(plug),
                        sources = plug.config.sources({
                            { name = 'nvim_lsp' },
                            { name = 'nvim_lsp_signature_help' },
                            { name = 'buffer' },
                            { name = 'luasnip' },
                            { name = 'path' },
                        })
                    })
                end,
            },
            'hrsh7th/cmp-nvim-lsp',
        },
        init = function()
            mappings.lsp()
            local lsp = require('lspconfig')
            local flsp = utils.import('functions/lsp')

            flsp.setup(lsp)
            flsp.setup_ui()
        end

    },
    -- dev
    {
        'tpope/vim-commentary',
    },
    {
        'mattn/emmet-vim',
    },
    -- git
    {
        'airblade/vim-gitgutter',
        config = function()
            mappings.gitgutter()
        end,
        opts = utils.import('settings/gitgutter').opts,
    },
    'itchyny/vim-gitbranch',
    {
        'tanvirtin/vgit.nvim',
        config = function() end,
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    },
    -- status line
    -- use  instead
    {
        'nvim-lualine/lualine.nvim',
        opts = utils.import('settings/lualine').opts
    },
    -- files
    {
        'preservim/nerdtree',
        init = function()
            mappings.nerdtree()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = function()
            mappings.telescope()
        end,
    },
    -- debugger
    {
        'mfussenegger/nvim-dap',
        init = function()
            local plug = require('dap')
            mappings.dap(plug)
            utils.import('functions/dap').setup_codelldb(plug)
        end,
    },
    -- go dap plug
    {
        'leoluz/nvim-dap-go',
        dependencies = {
            'mfussenegger/nvim-dap'
        },
        init = function()
            require('dap-go').setup()
        end,
    },
    -- python dap plug
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap'
        },
        init = function()
            require('dap-python').setup('python')
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        init = function()
            local dap, dapui = require('dap'), require('dapui')

            dapui.setup()

            utils.import('functions/dap').add_listeners_for_ui(dap, dapui)
        end,
    },
    -- highlight TODO, FIXME and etc
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = function()
            local plug = require('todo-comments')
            plug.setup()

            mappings.todo_comments(plug)
        end
    },
    -- list of diagnostics and etc
    {
        'folke/trouble.nvim',
        init = function()
            local plug = require('trouble')
            plug.setup(
                utils.import('settings/trouble').opts
            )

            mappings.trouble(plug)
        end
    },
    {
        'preservim/tagbar',
        init = function()
            mappings.tagbar()
        end
    },
})
