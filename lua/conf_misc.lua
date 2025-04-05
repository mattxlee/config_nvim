-- Default options:
require('gruvbox').setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = false,
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
  contrast = '', -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd('set background=dark')
vim.cmd('colorscheme gruvbox')
vim.cmd('highlight SignColumn guibg=0')

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
            position = 'float',
            mappings = {
                ['[c'] = 'prev_git_modified',
                [']c'] = 'next_git_modified'
            }
        }
    }
})
vim.keymap.set('n', '<c-j>', ':Neotree reveal<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree action=show toggle=true<CR>')

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

-- Fugitive
vim.keymap.set('n', '<c-g>', ':Git<CR>')

-- Find and replace in files
require('spectre').setup({
    open_cmd = 'vnew',
})
vim.keymap.set('n', '<leader>h', function()
    require('spectre').open()
end)

-- Fzf lua settings
require('fzf-lua').setup({
    winopts = {
        height = 0.9,
        width = 0.9,
        backdrop = 100,
    },
    keymap = {
        fzf = {
            ['ctrl-q'] = 'select-all+accept',
        },
    },
    fzf_colors = {
        true,   -- inherit fzf colors that aren't specified below from
        -- the auto-generated theme similar to `fzf_colors=true`
        ['fg']          = { 'fg', 'CursorLine' },
        ['bg']          = { 'bg', 'Normal' },
        ['hl']          = { 'fg', 'Comment' },
        ['fg+']         = { 'fg', 'Normal' },
        ['bg+']         = { 'bg', { 'CursorLine', 'Normal' } },
        ['hl+']         = { 'fg', 'Statement' },
        ['info']        = { 'fg', 'PreProc' },
        ['prompt']      = { 'fg', 'Conditional' },
        ['pointer']     = { 'fg', 'Exception' },
        ['marker']      = { 'fg', 'Keyword' },
        ['spinner']     = { 'fg', 'Label' },
        ['header']      = { 'fg', 'Comment' },
        ['gutter']      = '-1',
    },
})
vim.keymap.set('n', '<c-p>', ':FzfLua files<CR>')
vim.keymap.set('n', '<leader>l', ':FzfLua grep_cword<CR>')
vim.keymap.set('n', '<leader>f', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>z', ':FzfLua diagnostics_workspace<CR>')
vim.keymap.set('n', '<leader>o', ':FzfLua lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>g', ':FzfLua lsp_live_workspace_symbols<CR>')
vim.keymap.set('n', '<leader>b', ':FzfLua buffers<CR>')
vim.keymap.set('n', 'gr', ':FzfLua lsp_references<CR>')
vim.cmd('FzfLua register_ui_select')

-- Surround settings
require('nvim-surround').setup()

-- Settings for indent lines
local highlight = {
    'whitespace',
}
require('ibl').setup({
    indent = {
		char = '▏',
        highlight = highlight
    },
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
vim.keymap.set({ 'n', 'v' }, '<leader>to', function () require('todo-comments.fzf').todo({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end)

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
    border = 'rounded',
})
vim.keymap.set('n', '<leader>tt', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' }) -- Transparent content

-- Notify with message
-- Overriding vim.notify with fancy notify if fancy notify exists
local notify = require('notify')
vim.notify = notify
print = function(...)
    local print_safe_args = {}
    local _ = { ... }
    for i = 1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
    end
    notify(table.concat(print_safe_args, ' '), 'info')
end
notify.setup({
    render = 'wrapped-compact',
    stages = 'static',
})