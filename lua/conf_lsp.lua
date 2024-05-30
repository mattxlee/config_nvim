-- avoid the error highlights from lsp documents
vim.cmd [[
    hi link markdownError NONE
    let g:tex_conceal=''
    let g:vim_markdown_math=0
    let g:vim_markdown_conceal=0
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_conceal_code_blocks=0
]]

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- pop window with border config
local _border = 'rounded'
local bdopts = {
    border = _border,
    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
}

-- setup cmp
local cmp = require('cmp')
cmp.setup({
    completion = {
        autocomplete = false,
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    window = {
        completion = bdopts,
        documentation = bdopts,
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-l>'] = cmp.mapping.complete(),
        ['<c-k>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<c-n>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),
        ['<c-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<c-f>'] = cmp.mapping(function(fallback)
            if vim.fn['vsnip#available'](1) == 1 then
                feedkey('<Plug>(vsnip-expand-or-jump)', '')
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {'i', 's'}),
        ['<c-b>'] = cmp.mapping(function()
            if vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<Plug>(vsnip-jump-prev)', '')
            end
        end, {'i', 's'})
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
        { name = 'path' },
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    }
})

-- border for lsp info
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = _border }
)
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = false,
    }
)

vim.diagnostic.config {
    float = { border = _border }
}
require('lspconfig.ui.windows').default_options = {
    border = _border
}
