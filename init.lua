-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    ui = {
        size = { width = 0.8, height = 0.8 },
        backdrop = 100,
        border = 'rounded',
    },
    spec = {
        -- gruvbox theme
        { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
        -- editor config
        { 'editorconfig/editorconfig-vim' },
        -- Highlight the white space with red blocks
        { 'ntpeters/vim-better-whitespace' },
        -- Some extend highlights
        { 'mtdl9/vim-log-highlighting' },
        { 'cfdrake/vim-pbxproj' },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {
                columns = {
                    'icon',
                    -- 'permissions',
                    'size',
                    -- 'mtime',
                },
                use_default_keymaps = false,
                keymaps = {
                    ['q'] = 'actions.close',
                    ['g?'] = 'actions.show_help',
                    ['<CR>'] = 'actions.select',
                    ['<C-l>'] = 'actions.refresh',
                    ['<C-v>'] = 'actions.preview',
                    ['-'] = 'actions.parent',
                    ['_'] = 'actions.open_cwd',
                    ['`'] = 'actions.cd',
                    ['~'] = { 'actions.cd', opts = { scope = 'tab' } },
                    ['gs'] = 'actions.change_sort',
                    ['gx'] = 'actions.open_external',
                    ['g.'] = 'actions.toggle_hidden',
                    ['g\\'] = 'actions.toggle_trash',
                },
                view_options = {
                    show_hidden = true,
                },
            },
            config = true,
            -- Optional dependencies
            dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
            -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
            lazy = false,
        },
        -- Git related plugins
        { 'lewis6991/gitsigns.nvim' },
        -- Git operations
        { 'tpope/vim-fugitive'},
        -- Status line
        { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        -- Notify
        { 'rcarriga/nvim-notify'},
        -- Search and replace special window
        { 'windwp/nvim-spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
        -- Fzf lua
        { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        -- Surround with brackets and etc
        { 'kylechui/nvim-surround' },
        -- Show indent lines
        { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = true
            -- use opts = {} for passing setup options
            -- this is equivalent to setup({}) function
        },
        -- Flutter settings
        { 'akinsho/flutter-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
        -- Lsp related
        { 'vim-scripts/a.vim' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig' },
        -- Main complete plugin
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                -- Show icons from complete menu
                { 'onsails/lspkind.nvim' },
                -- Complete sources
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                -- Make selection with signature selection
                { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
                -- Signature help
                { 'hrsh7th/cmp-nvim-lsp-signature-help' },
                -- Progress of lsp loading
                { 'linrongbin16/lsp-progress.nvim' },
            },
        },
        { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
        -- Comment
        { 'numToStr/Comment.nvim' },
        -- Terminal
        { 'numToStr/FTerm.nvim' },
        {
            'CopilotC-Nvim/CopilotChat.nvim',
            dependencies = {
                { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
                { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
            },
            build = 'make tiktoken', -- Only on MacOS or Linux
            opts = {
                window = {
                    layout = 'float',
                    width = 0.9,
                    height = 0.9,
                },
                model = 'claude-3.7-sonnet',
            },
        },
    },
})

-- common setup --
vim.cmd('set maxmempattern=2000000')
vim.cmd('filetype indent on')

vim.cmd('autocmd InsertEnter * set nocursorline')
vim.cmd('autocmd InsertLeave * set cursorline')
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        local filetype = vim.bo.filetype
        if filetype == 'markdown' then
            -- vim.bo.breakat = ''
            vim.api.nvim_set_option_value('breakat', '', { scope = 'local' })
        else
            -- vim.bo.breakat = ' ^I!@*-+;:,./?'
            vim.api.nvim_set_option_value('breakat', ' \t!@*-+;:,./?', { scope = 'local' })
        end
    end,
})

-- leader key
vim.g.mapleader = ';'

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.mouse = ''
vim.o.updatetime = 300
vim.o.incsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.cursorline = true
vim.o.smartindent = false
vim.o.autoindent = true
vim.o.linebreak = true
vim.o.signcolumn = 'yes'

-- open Lazy plugin manager window
vim.keymap.set('n', '<leader>a', ':Lazy<CR>')

-- '*' highlights all same strings without jumping to next one
vim.keymap.set('n', '*', ':keepjumps normal! mi*`i<CR>')

-- split/vsplit window and jump to next by using double <leader> keys
vim.keymap.set('n', '<leader>v', ':vsp<CR>')
vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader>w', '<c-w>w')
vim.keymap.set('n', '<leader>W', '<c-w>W')
vim.keymap.set('n', '<leader><leader>', '<c-w>x')
vim.keymap.set('n', '<leader>=', '<c-w>=')

-- remove trailing whitespaces
vim.keymap.set('n', '<leader>x', ':StripWhitespace<CR>')
vim.keymap.set('n', ']x', ':NextTrailingWhitespace<CR>')
vim.keymap.set('n', '[x', ':PrevTrailingWhitespace<CR>')

-- navigate in fix window
vim.keymap.set('n', '<leader>j', ':cnext<CR>')
vim.keymap.set('n', '<leader>k', ':cprev<CR>')

-- close all other windows
vim.keymap.set('n', 'K', ':only<CR>')

-- close all buffers
vim.keymap.set('n', '<leader>q', ':%bd<CR>')

-- hide the highlights
vim.keymap.set('n', '<leader>n', ':noh<CR>')

-- copy to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n' }, '<leader>p', '"+p')

-- other settings
require('conf_misc')

-- load lsp config --
require('conf_lsp')
require('conf_lsp_languages')