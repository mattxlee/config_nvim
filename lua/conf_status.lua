require('lualine').setup({
    options = {
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
        theme = 'dracula',
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
