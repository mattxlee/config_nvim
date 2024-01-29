-- todos
vim.keymap.set('n', '<leader>t', ':TodoQuickFix<CR>')

vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Next todo comment' })

require('todo-comments').setup({
    signs = false,
});

