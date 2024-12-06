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
local _border = nil
local bdopts = {
    border = _border,
    winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel,Search:None',
}

-- setup cmp
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
    preselect = cmp.PreselectMode.None,
    sorting = {
        priority_weight = 100,
        comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.order,
            -- cmp.config.compare.exact,
            -- cmd.config.compare.kind,
            -- cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
        },
    },
    completion = {
        completeopt = 'menu,menuone,preview,noinsert,select',
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    window = {
        completion = bdopts,
        documentation = bdopts,
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-l>'] = cmp.mapping.complete(),
        ['<c-k>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({
            select = true
        }),
        ['<c-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<c-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<c-f>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<c-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help', priority = 200 },
        { name = 'nvim_lsp', priority = 90 },
        { name = 'path', priority = 20 },
        { name = 'buffer', priority = 10 },
        { name = 'luasnip', priority = 3 },
        { name = 'emoji', priority = 1 },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    }
})

-- do not update diagnostics when current edit mode is 'insert'
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = false,
    }
)

require('lsp-progress').setup()

-- Format current doc
local format_current_buffer = function()
  vim.lsp.buf.format({
    async = true,
    timeout_ms = 10000,
  })
end
vim.keymap.set('n', '<leader>t', format_current_buffer)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)