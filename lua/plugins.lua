return require('packer').startup({function()
    use 'wbthomason/packer.nvim'

    use 'embear/vim-localvimrc'

    use 'sainnhe/gruvbox-material'

    use 'itchyny/lightline.vim'

    use 'tpope/vim-fugitive'

    use 'tpope/vim-vinegar'

    use 'editorconfig/editorconfig-vim'

    use 'Yggdroot/LeaderF'

    use 'sbdchd/neoformat'

    use 'airblade/vim-gitgutter'

    use 'skywind3000/asyncrun.vim'

    use 'tpope/vim-surround'

    use 'tomtom/tcomment_vim'

    use 'eugen0329/vim-esearch'

    use 'ludovicchabant/vim-gutentags'

    use 'ntpeters/vim-better-whitespace'

    use {'neoclide/coc.nvim', branch = 'release'}
end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
