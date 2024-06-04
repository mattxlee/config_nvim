local on_attach = function(client, bufnr)
    -- diagnostic
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
vim.keymap.set('n', '<leader>m', ':Mason<CR>')

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
require('flutter-tools').setup({
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

local langs = { 'cmake', 'rust_analyzer', 'texlab', 'gopls', 'tsserver', 'tailwindcss',  'cssls', 'pylsp'}
for _, lang in ipairs(langs) do
    require('lspconfig')[lang].setup(setup_entries)
end

-- fix: renaming buffer newer than edits
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end
    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end