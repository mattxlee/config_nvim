local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup({function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    pcall(function()
        -- color scheme
        use 'ellisonleao/gruvbox.nvim'
        -- read local config files
        use {
            'klen/nvim-config-local',
            config = function()
                require('config-local').setup {
                    -- Default options (optional)

                    -- Config file patterns to load (lua supported)
                    config_files = { '.nvim.lua', '.nvimrc', '.exrc' },

                    -- Where the plugin keeps files data
                    hashfile = vim.fn.stdpath('data') .. '/config-local',

                    autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
                    commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
                    silent = false,             -- Disable plugin messages (Config loaded/ignored)
                    lookup_parents = false,     -- Lookup config files in parent directories
                }
            end
        }
        -- external file types
        use 'mtdl9/vim-log-highlighting'
        use 'cfdrake/vim-pbxproj'
        -- todo highlighting
        use {
            'folke/todo-comments.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
        }
        -- file tree explorer
        use {
            'stevearc/oil.nvim',
            config = function()
                require('oil').setup()
            end,
        }
        -- status line
        use {
            'nvim-lualine/lualine.nvim',
        }
        -- git related
        use 'lewis6991/gitsigns.nvim'
        use 'tpope/vim-fugitive'
        -- search in files and replace
        use {
            'windwp/nvim-spectre',
            requires = { 'nvim-lua/plenary.nvim' },
        }
        -- Telescope
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.4',
            -- or                          , branch = '0.1.x',
            requires = { 'nvim-lua/plenary.nvim' },
        }
        -- editorconfig
        use 'editorconfig/editorconfig-vim'
        -- hop goto anywhere easily
        use {
            'phaazon/hop.nvim',
            branch = 'v2', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
            end,
        }
        -- comment lines
        use 'tomtom/tcomment_vim'
        -- surround with text/object etc.
        use {
            'kylechui/nvim-surround',
            tag = '*', -- Use for stability; omit to use `main` branch for the latest features
            config = function()
                require('nvim-surround').setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end,
        }
        -- trailing whitespaces
        use 'ntpeters/vim-better-whitespace'
    end)
    -- Sync plugins on first time starts up
    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
    display = {
        open_fn = require('packer.util').float
    }
}})

