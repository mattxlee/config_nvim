local _border = 'rounded'

local function bordered_hover(_opts)
    _opts = _opts or {}
    return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
        border = _border
    }))
end

local function bordered_signature_help(_opts)
    _opts = _opts or {}
    return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", _opts, {
        border = _border
    }))
end

local on_attach = function(client, bufnr)
    -- diagnostic
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- language options
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gh', bordered_hover, bufopts)
    vim.keymap.set('n', 'gs', bordered_signature_help, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

vim.keymap.set('n', '<leader>m', ':Mason<CR>')
require('mason').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '💡',
        }
    }
})

-- fix: renaming buffer newer than edits
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end
    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end

-- workaround: ignore ServerCancelled error
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end