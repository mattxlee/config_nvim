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
    preselect = cmp.PreselectMode.Item,
    select_behavior = cmp.SelectBehavior.Select,
    completion = {
        completeopt = 'menu,menuone,preview,noinsert',
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
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
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
        { name = 'nvim_lsp', priority = 150 },
        { name = 'luasnip', priority = 100 },
        { name = 'path', priority = 70 },
        { name = 'buffer', priority = 50 },
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
vim.keymap.set('n', '<leader>i', format_current_buffer)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- Create an autocommand for when LSP attaches to a buffer
local inlay_check_timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        -- Create a repeating timer that checks every second
        inlay_check_timer:start(0, 1000, vim.schedule_wrap(function()
            -- Check if inlay hints are available and enable them
            if vim.lsp.inlay_hint and vim.api.nvim_get_mode().mode ~= 'i' then
                vim.lsp.inlay_hint.enable(true)  -- Enable inlay hints when ready
            end
        end))
    end,
})

-- Enable inlay hints only in normal mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    callback = function()
        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
        end
    end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function()
        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
        end
    end,
})