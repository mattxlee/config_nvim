require('mini.pairs').setup()

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
    indent = { enable = false },
})
-- register filetype `ejs`
vim.filetype.add({
    extension = {
        ejs = 'ejs',
    }
})
-- use html parser to parse *.ejs files
vim.treesitter.language.register('html', 'ejs')

-- Default options:
require('gruvbox').setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = '', -- can be 'hard', 'soft' or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd('colorscheme gruvbox')

require('oil').setup()
vim.keymap.set('n', '<c-j>', ':Oil<CR>')

require('lualine').setup({
    options = {
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
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
    builtin.find_files(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.keymap.set('n', '<leader>l', function()
    builtin.grep_string(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.keymap.set('n', '<leader>f', function()
    builtin.live_grep(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.keymap.set('n', '<leader>o', function()
    builtin.lsp_document_symbols(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.keymap.set('n', '<leader>g', function()
    builtin.lsp_dynamic_workspace_symbols(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.keymap.set('n', 'gr', function()
    builtin.lsp_references(require('telescope.themes').get_cursor({ previewer = false }))
end)
vim.cmd('highlight link TelescopeSelection PmenuSel')
vim.cmd('highlight link TelescopeMatching GruvboxYellow')

require('nvim-surround').setup()