-- Default options
require('dracula').setup({
    soft = true,
    override = {
        ['@type'] = { italic = false, bold = true },
        ['@type.definition'] = { italic = false, bold = true },
        ['@type.builtin'] = { italic = false, bold = true },
        ['@type.builtin.cpp'] = { italic = false, bold = true },
        ['@attribute'] = { italic = false, bold = false },
        ['@function'] = { italic = false, bold = false },
        ['@comment'] = { italic = true, bold = false },
        ['@keyword'] = { italic = false, bold = false },
        ['@constant'] = { italic = false, bold = false },
        ['@variable'] = { italic = false, bold = false },
        ['@field'] = { italic = false, bold = false },
        ['@parameter'] = { italic = false, bold = false },
        ['@lsp.type.comment'] = { italic = false, bold = false },
        ['@lsp.typemod.parameter.readyonly'] = { italic = false, bold = false },
    },
})

vim.cmd [[
    colorscheme dracula

    hi DiagnosticUnderlineError cterm=underline gui=underline guifg=#ee6666
    hi DiagnosticUnderlineWarn cterm=underline gui=underline guifg=orange

    hi DiagnosticSignError cterm=none gui=none guifg=#ee6666 guibg=#44475a
    hi DiagnosticSignWarn cterm=none gui=none guifg=orange guibg=#44475a

    hi DiagnosticVirtualTextError cterm=none gui=none guifg=#ee6666 guibg=#44475a
    hi DiagnosticVirtualTextWarn cterm=none gui=none guifg=orange guibg=#44475a

    hi Comment cterm=italic gui=italic guifg=#7b7f8b
    hi Type cterm=bold gui=bold guifg=#adf6f6
    hi Search cterm=none gui=none guibg=#ffb866 guifg=black
    hi CursorLineNr guifg=white guibg=#44475a
]]
