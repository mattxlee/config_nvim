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
    { 'stevearc/dressing.nvim' },
    { 'editorconfig/editorconfig-vim' },
    { 'echasnovski/mini.nvim', version= '*' },
    -- Comment code respect the language
    { 'tomtom/tcomment_vim' },
    -- Highlight the white space with red blocks
    { 'ntpeters/vim-better-whitespace' },
    -- Switch between h/cpp
    { 'jakemason/ouroboros', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Some extend highlights
    { 'mtdl9/vim-log-highlighting' },
    { 'cfdrake/vim-pbxproj' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Theme
    { 'ellisonleao/gruvbox.nvim' },
    -- Tree-view explorer
    { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x', dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' } },
    -- Status line
    { 'nvim-lualine/lualine.nvim' },
    -- Search and replace special window
    { 'windwp/nvim-spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Huge telescope plugins
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Surround with brackets and etc
    { 'kylechui/nvim-surround' },
    -- Show indent lines
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    -- Generate documents from current code
    { 'danymat/neogen', config = true, version = '*' },
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
    { 'hrsh7th/cmp-buffer' },
    -- Make selection with signature selection
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },
    -- Signature help
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    -- Inlay hints
    { 'lvimuser/lsp-inlayhints.nvim' },
    -- Progress of lsp loading
    { 'linrongbin16/lsp-progress.nvim' },
    -- Format document
    { 'sbdchd/neoformat' },
    -- Git related plugins
    { 'lewis6991/gitsigns.nvim' },
    { 'tpope/vim-fugitive' },
})

-- common setup --
vim.cmd('set maxmempattern=2000000')
vim.cmd('autocmd FileType markdown set breakindentopt=shift:0')
vim.cmd('autocmd FileType tex set breakindentopt=shift:0')

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
vim.o.linebreak = true
vim.o.breakindent = true
vim.opt.breakindentopt = { 'shift:8', 'sbr' }

-- important to avoid preview items from auto-complete list
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

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

require('conf_plugins')

-- load lsp config --
require('conf_lsp')
require('conf_lsp_languages')