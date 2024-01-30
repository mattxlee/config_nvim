local on_attach = function(client, bufnr)
    -- diagnostic
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    -- language options
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

require('mason').setup()
require('mason-lspconfig').setup()

vim.keymap.set('n', '<c-h>', ':ClangdSwitchSourceHeader<CR>')
vim.keymap.set('n', '<leader>c', ':Mason<CR>')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- clangd
require('lspconfig').clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        'clangd',
        '-j=3',
        '--header-insertion=never',
    },
})

-- flutter tools
require("flutter-tools").setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
})

-- common settings
local setup_entries = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local langs = { 'cmake', 'rust_analyzer', 'texlab', 'gopls', 'tsserver', 'tailwindcss', 'pylsp'}
for _, lang in ipairs(langs) do
    require('lspconfig')[lang].setup(setup_entries)
end

