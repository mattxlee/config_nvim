return require('packer').startup({function()
    use 'vim-scripts/a.vim'

    use 'wbthomason/packer.nvim'

    use 'morhetz/gruvbox'

    use 'liuchengxu/eleline.vim'

    use 'tpope/vim-fugitive'

    use 'editorconfig/editorconfig-vim'

    use 'Yggdroot/LeaderF'

    use 'kien/ctrlp.vim'

    use 'sbdchd/neoformat'

    use 'airblade/vim-gitgutter'

    use 'skywind3000/asyncrun.vim'

    use 'tpope/vim-surround'

    use 'tomtom/tcomment_vim'

    use 'eugen0329/vim-esearch'

    use 'ludovicchabant/vim-gutentags'

    use 'ntpeters/vim-better-whitespace'

    use 'vim-scripts/DoxygenToolkit.vim'

    use 'mhinz/vim-startify'

    use 'preservim/nerdtree'

    use 'godlygeek/tabular'

    use 'preservim/vim-markdown'

    use 'neovim/nvim-lspconfig'

    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/cmp-nvim-lsp'

    use 'hrsh7th/nvim-cmp'

    use 'nvim-lua/lsp-status.nvim'
end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
