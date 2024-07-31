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

vim.keymap.set('n', '<leader>m', ':Mason<CR>')
require('mason').setup()

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

require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
})

vim.cmd [[
sign define DiagnosticSignError text=  linehl= texthl=DiagnosticSignError numhl=
sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl=
sign define DiagnosticSignHint text=💡  linehl= texthl=DiagnosticSignHint numhl=
]]

-- fix: renaming buffer newer than edits
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end
    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end