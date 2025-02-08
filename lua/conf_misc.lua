-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath('cache') .. '/nightfox',
    compile_file_suffix = '_compiled', -- Compiled file suffix
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = 'italic',     -- Value is any valid attr-list value `:help attr-list`
      conditionals = 'NONE',
      constants = 'bold',
      functions = 'italic',
      keywords = 'bold',
      numbers = 'NONE',
      operators = 'NONE',
      strings = 'NONE',
      types = 'NONE',
      variables = 'NONE',
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})
-- Fix the color and highlights from telescope dialogs.
vim.cmd('hi! Pmenu guibg=None')

-- setup must be called before loading
vim.cmd('colorscheme duskfox')

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
vim.keymap.set('n', '<leader>j', ':Neotree action=show toggle=true<CR>')

-- Status bar
local opts = {
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
}
require('lualine').setup(opts)

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

-- Neogit
local neogit = require('neogit')
neogit.setup({
    disable_context_highlighting = true,
    disable_insert_on_commit = true,
})
vim.keymap.set('n', '<c-g>', ':Neogit kind=floating<CR>')

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
})
require('telescope').load_extension('ui-select')

vim.keymap.set('n', '<c-p>', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>l', ':Telescope grep_string<CR>')
vim.keymap.set('n', '<leader>f', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>e', ':Telescope symbols<CR>')
vim.keymap.set('n', '<leader>z', ':Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>o', ':Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>g', ':Telescope lsp_workspace_symbols<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope notify<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')

local telescope = require('telescope')
-- Setup shortcuts for telegram
telescope.setup({
    defaults = {
        mappings = {
            i = { ['<c-j>'] = actions.move_selection_next, ['<c-k>'] = actions.move_selection_previous },
        },
    },
})

-- Surround settings
require('nvim-surround').setup()

-- Settings for indent lines
local highlight = {
    'whitespace',
}
require('ibl').setup({
    indent = { highlight = highlight },
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
    end
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- TODO
require('todo-comments').setup()
vim.keymap.set('n', '<leader>to', ':TodoTelescope<CR>')

vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- Copilot short cuts
vim.keymap.set({ 'n', 'v' }, '<leader>cc', ':CopilotChatToggle<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>ce', ':CopilotChatExplain<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>ct', ':CopilotChatTests<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>cr', ':CopilotChatReview<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>cf', ':CopilotChatFix<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>cm', ':CopilotChatCommit<CR>')

-- Comment
require('Comment').setup()

-- Term
require('FTerm').setup({
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
    border = 'single',
})
vim.keymap.set('n', '<leader>tt', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Notify with message
-- Overriding vim.notify with fancy notify if fancy notify exists
local notify = require("notify")
vim.notify = notify
print = function(...)
    local print_safe_args = {}
    local _ = { ... }
    for i = 1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
    end
    notify(table.concat(print_safe_args, ' '), "info")
end
notify.setup({
    render = 'wrapped-compact',
    stages = 'static',
})