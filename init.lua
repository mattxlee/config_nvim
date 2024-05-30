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
    { 'tomtom/tcomment_vim' },
    { 'ntpeters/vim-better-whitespace' },
    { 'mtdl9/vim-log-highlighting' },
    { 'cfdrake/vim-pbxproj' },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- A list of parser names, or 'all'
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                auto_install = true,
                -- List of parsers to ignore installing (for 'all')
                ignore_install = {},
                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = '/some/path/to/store/parsers',
                -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!
                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = {},
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            }
            -- register filetype `ejs`
            vim.filetype.add({
                extension = {
                    ejs = 'ejs',
                }
            })
            -- use html parser to parse *.ejs files
            vim.treesitter.language.register('html', 'ejs')
        end
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'auto', -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = 'latte',
                    dark = 'mocha',
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = 'dark',
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                no_underline = false, -- Force no underline
                styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { 'italic' }, -- Change the style of comments
                    conditionals = { 'bold' },
                    loops = {},
                    functions = { 'italic' },
                    keywords = { 'bold' },
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = '',
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
            vim.cmd.colorscheme 'catppuccin-macchiato'
        end
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
            vim.keymap.set('n', '<c-j>', ':Oil<CR>')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = false,
                    component_separators = '',
                    section_separators = '',
                    theme = 'catppuccin',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype', 'lsp_progress' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
              on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end
                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then return ']c' end
                  vim.schedule(function() gs.next_hunk() end)
                  return '<Ignore>'
                end, {expr=true})

                map('n', '[c', function()
                  if vim.wo.diff then return '[c' end
                  vim.schedule(function() gs.prev_hunk() end)
                  return '<Ignore>'
                end, {expr=true})
              end
            })
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<C-g>', ':Git<CR>')
        end
    },
    {
        'windwp/nvim-spectre',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('spectre').setup({
                open_cmd = 'new',
            })
            vim.keymap.set('n', '<leader>h', function()
                require('spectre').open()
            end)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        }
                    }
                },
            })
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<c-p>', function()
                builtin.find_files(require('telescope.themes').get_ivy({ previewer = false }))
            end)
            vim.keymap.set('n', '<leader>l', function()
                builtin.grep_string(require('telescope.themes').get_ivy({ previewer = false }))
            end)
            vim.keymap.set('n', '<leader>f', function()
                builtin.live_grep(require('telescope.themes').get_ivy({ previewer = false }))
            end)
            vim.keymap.set('n', '<leader>o', function()
                builtin.lsp_document_symbols(require('telescope.themes').get_ivy({ previewer = false }))
            end)
            vim.keymap.set('n', '<leader>g', function()
                builtin.lsp_dynamic_workspace_symbols(require('telescope.themes').get_ivy({ previewer = false }))
            end)
            vim.keymap.set('n', 'gr', function()
                builtin.lsp_references(require('telescope.themes').get_ivy({ previewer = false }))
            end)
        end
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    },
})

-- common setup --
vim.cmd [[set maxmempattern=2000000]]
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions+=mM]]
vim.cmd [[autocmd FileType c,cpp,objc set nocindent]]
vim.cmd [[autocmd FileType markdown set breakat=]]
vim.cmd [[autocmd FileType markdown set nobreakindent]]

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

-- '*' highlights all same strings without jumping to next one
vim.keymap.set('n', '*', ':keepjumps normal! mi*`i<CR>')

-- easy to browse bottom window
vim.keymap.set('n', '<leader>j', ':cnext<CR>')
vim.keymap.set('n', '<leader>k', ':cprev<CR>')

-- split/vsplit window and jump to next by using double <leader> keys
vim.keymap.set('n', '<leader>v', ':vsp<CR>')
vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader><leader>', '<c-w>w')

-- remove trailing whitespaces
vim.keymap.set('n', '<leader>x', ':StripWhitespace<CR>')
vim.keymap.set('n', ']x', ':NextTrailingWhitespace<CR>')
vim.keymap.set('n', '[x', ':PrevTrailingWhitespace<CR>')

-- close all other windows
vim.keymap.set('n', 'K', ':only<CR>')

-- hide the highlights
vim.keymap.set('n', '<leader>n', ':noh<CR>')
