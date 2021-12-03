return require('packer').startup({function()
    use 'wbthomason/packer.nvim'

    use 'embear/vim-localvimrc'

    use 'sainnhe/gruvbox-material'

    use 'itchyny/lightline.vim'

    use 'tpope/vim-fugitive'

    use 'editorconfig/editorconfig-vim'

    use 'Yggdroot/LeaderF'

    use 'sbdchd/neoformat'

    use 'mattxlee/vim-fswitch'

    use 'airblade/vim-gitgutter'

    use 'preservim/nerdtree'

    use 'skywind3000/asyncrun.vim'

    use 'tpope/vim-surround'

    use 'tomtom/tcomment_vim'

    use 'easymotion/vim-easymotion'

    use 'eugen0329/vim-esearch'

    use 'ludovicchabant/vim-gutentags'

    use 'ntpeters/vim-better-whitespace'

    use 'neovim/nvim-lspconfig'

    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/cmp-nvim-lsp'

    use 'hrsh7th/nvim-cmp'
end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
