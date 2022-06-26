return require('packer').startup({function()
    use 'vim-scripts/a.vim'

    use 'wbthomason/packer.nvim'

    use 'morhetz/gruvbox'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end
    }

    use 'editorconfig/editorconfig-vim'

    use 'Yggdroot/LeaderF'

    use 'sbdchd/neoformat'

    use 'tpope/vim-fugitive'

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local function map(mode, lhs, rhs, opts)
                        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
                        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                    end
                    -- Navigation
                    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
                    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
                end,
                current_line_blame = true
            }
        end
    }

    use 'skywind3000/asyncrun.vim'

    use 'tpope/vim-surround'

    use 'tomtom/tcomment_vim'

    use 'eugen0329/vim-esearch'

    use 'ludovicchabant/vim-gutentags'

    use 'ntpeters/vim-better-whitespace'

    use 'vim-scripts/DoxygenToolkit.vim'

    use 'tpope/vim-vinegar'

    use 'godlygeek/tabular'

    use 'preservim/vim-markdown'

    use 'neovim/nvim-lspconfig'

    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/cmp-nvim-lsp'

    use 'hrsh7th/nvim-cmp'

    use 'nvim-lua/lsp-status.nvim'

    use 'jackguo380/vim-lsp-cxx-highlight'

    use 'ryanoasis/vim-devicons'

    use 'kyazdani42/nvim-tree.lua'

    use 'stevearc/dressing.nvim'

    use 'natecraddock/sessions.nvim'

    use 'natecraddock/workspaces.nvim'

    use {'akinsho/toggleterm.nvim',
        tag = 'v1.*',
        config = function()
            require("toggleterm").setup()
        end}
end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
