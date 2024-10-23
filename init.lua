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
    { 'editorconfig/editorconfig-vim' },
    -- Comment code respect the language
    { 'tomtom/tcomment_vim' },
    -- Highlight the white space with red blocks
    { 'ntpeters/vim-better-whitespace' },
    -- Some extend highlights
    { 'mtdl9/vim-log-highlighting' },
    { 'cfdrake/vim-pbxproj' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Theme
    { 'ellisonleao/gruvbox.nvim' },
    -- Tree-view explorer
    { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x', dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'nvim-tree/nvim-web-devicons' } },
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
    -- Generate documents from current code
    { 'danymat/neogen', config = true, version = '*' },
    -- Zen mode?
    { 'shortcuts/no-neck-pain.nvim', version = '*' },
    -- Flutter settings
    { 'akinsho/flutter-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Lsp related
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    -- Main complete plugin
    { 'hrsh7th/nvim-cmp' },
    -- Show icons from complete menu
    { 'onsails/lspkind.nvim' },
    -- Complete sources
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    -- Make selection with signature selection
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    -- Signature help
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    -- Progress of lsp loading
    { 'linrongbin16/lsp-progress.nvim' },
    -- Git related plugins
    { 'lewis6991/gitsigns.nvim' },
    {
        'kdheepak/lazygit.nvim',
        cmd = {
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        -- optional for floating window border decoration
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { '<c-g>', '<cmd>LazyGit<CR>', desc = 'LazyGit' }
        }
    },
})

-- common setup --
vim.cmd('set maxmempattern=2000000')
vim.cmd('filetype indent on')

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
vim.o.signcolumn = 'yes'

-- line break settings

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

-- remove trailing whitespaces
vim.keymap.set('n', '<leader>x', ':StripWhitespace<CR>')
vim.keymap.set('n', ']x', ':NextTrailingWhitespace<CR>')
vim.keymap.set('n', '[x', ':PrevTrailingWhitespace<CR>')

-- close all other windows
vim.keymap.set('n', 'K', ':only<CR>')

-- hide the highlights
vim.keymap.set('n', '<leader>n', ':noh<CR>')

-- copy to clipboard
vim.keymap.set('n', '<leader>c', '"*y"')

-- other settings
require('conf_plugins')

-- load lsp config --
require('conf_lsp')
require('conf_lsp_languages')