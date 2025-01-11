local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- theme
    { "EdenEast/nightfox.nvim" },
    -- editor config
    { 'editorconfig/editorconfig-vim' },
    -- Comment code respect the language
    { 'tomtom/tcomment_vim' },
    -- Highlight the white space with red blocks
    { 'ntpeters/vim-better-whitespace' },
    -- Some extend highlights
    { 'mtdl9/vim-log-highlighting' },
    { 'cfdrake/vim-pbxproj' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Tree-view explorer
    { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x', dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'nvim-tree/nvim-web-devicons' } },
    -- Git related plugins
    { 'lewis6991/gitsigns.nvim' },
    -- Fugitive
    { 'tpope/vim-fugitive' },
    -- Status line
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    -- Search and replace special window
    { 'windwp/nvim-spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Huge telescope plugins
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' } },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
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
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
            { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {
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

-- easy to browse bottom window
vim.keymap.set('n', '<leader>j', ':cnext<CR>')
vim.keymap.set('n', '<leader>k', ':cprev<CR>')

-- split/vsplit window and jump to next by using double <leader> keys
vim.keymap.set('n', '<leader>v', ':vsp<CR>')
vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader>w', '<c-w>w')
vim.keymap.set('n', '<leader>W', '<c-w>W')
vim.keymap.set('n', '<leader><leader>', '<c-w>x')

-- remove trailing whitespaces
vim.keymap.set('n', '<leader>x', ':StripWhitespace<CR>')
vim.keymap.set('n', ']x', ':NextTrailingWhitespace<CR>')
vim.keymap.set('n', '[x', ':PrevTrailingWhitespace<CR>')

-- close all other windows
vim.keymap.set('n', 'K', ':only<CR>')

-- hide the highlights
vim.keymap.set('n', '<leader>n', ':noh<CR>')

-- copy to clipboard
vim.keymap.set('n', '<leader>y', '"*y')

-- other settings
require('conf_misc')

-- load lsp config --
require('conf_lsp')
require('conf_lsp_languages')