-- Gruvbox, the theme
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
vim.cmd('set background=dark')
vim.cmd('colorscheme gruvbox')

-- Treesitter for highlighting keywords, functions and etc
require('nvim-treesitter.configs').setup({
    -- A list of parser names, or 'all'
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown' },
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

-- Tree view from the left draw
require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        window = {
            mappings = {
                ['[c'] = 'prev_git_modified',
                [']c'] = 'next_git_modified'
            }
        }
    }
})
vim.keymap.set('n', '<c-j>', ':Neotree reveal<CR>')
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>')

-- Status bar
require('lualine').setup({
    options = {
        icons_enabled = true,
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

-- Git sign settings
require('gitsigns').setup({
    current_line_blame = true,
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
        map('n', '<leader>rr', gs.reset_hunk)
    end
})

-- Fugitive
vim.keymap.set('n', '<c-g>', ':Git<CR>')

-- Find and replace in files
require('spectre').setup({
    open_cmd = 'new',
})
vim.keymap.set('n', '<leader>h', function()
    require('spectre').open()
end)

-- Telescope settings
local actions = require('telescope.actions')
require('telescope').setup({
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_cursor({ previewer = false })
        },
    },
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    },
})
require('telescope').load_extension('ui-select')

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
vim.keymap.set('n', '<leader>e', function()
    require('telescope.builtin').symbols(require('telescope.themes').get_cursor({ previewer = false, sources = {'emoji', 'kaomoji', 'gitmoji'} }))
end)
-- Fix the color and highlights from telescope dialogs.
vim.cmd('highlight link TelescopeSelection PmenuSel')
vim.cmd('highlight link TelescopeMatching GruvboxYellow')
vim.cmd('highlight SignColumn guibg=0')
vim.cmd('highlight Pmenu guibg=#3c3836')

-- Surround settings
require('nvim-surround').setup()

-- Settings for indent lines
require('ibl').setup({
    scope = { enabled = false },
})

-- Switch header/source
vim.keymap.set('n', '<c-h>', ':ClangdSwitchSourceHeader<CR>')

-- Set markdown line-break mode.
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function ()
        if (vim.tbl_contains({'text', 'markdown'}, vim.o.filetype)) then
            vim.o.linebreak = true
            vim.o.breakindent = true
            vim.opt.breakindentopt = { 'shift:0', 'sbr' }
        else
            vim.o.linebreak = true
            vim.o.breakindent = true
            vim.opt.breakindentopt = { 'shift:4', 'sbr' }
        end
        MiniMap.open()
    end
})

-- Settings for Markdown preview
vim.g.mkdp_auto_close = 0

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- Minimap
local MiniMap = require 'mini.map'
local diagnostic_integration = MiniMap.gen_integration.diagnostic({
    error = 'DiagnosticFloatingError',
    warn  = 'DiagnosticFloatingWarn',
    info  = 'DiagnosticFloatingInfo',
    hint  = 'DiagnosticFloatingHint',
})
MiniMap.setup {
    integrations = {
        MiniMap.gen_integration.builtin_search(),
        MiniMap.gen_integration.diff(),
        MiniMap.gen_integration.gitsigns(),
        diagnostic_integration,
    },
    symbols = {
        encode = MiniMap.gen_encode_symbols.dot '4x2',
    },
}

vim.api.nvim_create_autocmd('VimEnter', {
    callback = MiniMap.open,
})

vim.api.nvim_create_autocmd('WinClosed', {
    callback = MiniMap.refresh,
})

vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    callback = function()
        local _, col = unpack(vim.api.nvim_win_get_cursor(0))
        local width = vim.api.nvim_win_get_width(0)
        if width - col < 20 then
            MiniMap.close()
        else
            MiniMap.open()
        end
    end,
})

-- TODO
require('todo-comments').setup()

vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

vim.keymap.set('n', '<leader>t', ':TodoQuickFix<CR>')