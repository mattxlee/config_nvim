require('spectre').setup({
    open_cmd = 'new',
})

vim.keymap.set('n', '<leader>h', function()
    require('spectre').open()
end)
