-- install packer if not installer
local lazypath = vim.fn.stdpath('config') .. 'data/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local mappings = require('mappings/plugins')

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
                require('settings/treesitter').opts
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- right order is:
            -- 1. mason
            -- 2. mason-lspconfig
            -- 3. lspconfig
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = {
                    {
                        'williamboman/mason.nvim',
                        init = function()
                            local plug = require('mason')
                            plug.setup()
                            require('functions/mason').install_required(plug)
                        end,
                    },
                },
                init = function()
                    local plug = require('mason-lspconfig')
                    plug.setup()
                 end,
            },

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
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local lsp = require('lspconfig')
            local settings = require('settings/lsp')

            for _, server in pairs(settings.configs) do
                if server.preload_cmd ~= nil then
                    -- local result = vim.fn.system(server.preload_cmd)
                end
                lsp[server.name].setup{
                    settings = server.settings,
                    on_attach = require('functions/lsp').on_attach,
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150,
                    }
                }
            end
        end

    },
    -- dev
    {
        'majutsushi/tagbar',
        config = function()
            require('settings/tagbar').setup()
            mappings.tagbar()
        end,
    },
    'tpope/vim-commentary',
    'mattn/emmet-vim',
    -- git
    {
        'airblade/vim-gitgutter',
        config = function()
            mappings.gitgutter()
        end,
        opts = require('settings/gitgutter').opts,
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
        opts = require('settings/lualine').opts
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
            require('functions/dap').setup_codelldb(plug)
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

            require('functions/dap').add_listeners_for_ui(dap, dapui)
        end,
    },
        -- auto-resize windows
    {
        'anuvyklack/windows.nvim',
        dependencies = 'anuvyklack/middleclass',
        init = function()
            local plug = require('windows')
            plug.setup()
        end
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
})

