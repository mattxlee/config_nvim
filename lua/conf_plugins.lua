require('nvim-treesitter.configs').setup({
    -- A list of parser names, or 'all'
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown' },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
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
    indent = { enable = true },
})
-- register filetype `ejs`
vim.filetype.add({
    extension = {
        ejs = 'ejs',
    }
})
-- use html parser to parse *.ejs files
vim.treesitter.language.register('html', 'ejs')

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
vim.cmd.colorscheme 'catppuccin-latte'

require('oil').setup()
vim.keymap.set('n', '<c-j>', ':Oil<CR>')

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
        lualine_x = { 'encoding', 'fileformat', 'filetype', function()
            return require('lsp-progress').progress()
        end },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
})

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
vim.keymap.set('n', '<C-g>', ':Git<CR>')

require('spectre').setup({
    open_cmd = 'new',
})
vim.keymap.set('n', '<leader>h', function()
    require('spectre').open()
end)

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

require('nvim-surround').setup()