local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
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

require('telescope').load_extension('flutter')
vim.keymap.set('n', '<leader>u', function()
    require('telescope').extensions.flutter.commands()
end)
