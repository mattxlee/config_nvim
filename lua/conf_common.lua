vim.cmd [[set maxmempattern=2000000]]
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions+=mM]]
vim.cmd [[autocmd FileType c,cpp,objc set nocindent]]
vim.cmd [[autocmd FileType markdown set breakat=]]
vim.cmd [[autocmd FileType markdown set nobreakindent]]

-- leader key
vim.g.mapleader = ';'

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.mouse = false
vim.o.updatetime = 300
vim.o.incsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.cursorline = true
vim.o.smartindent = false
vim.o.autoindent = true
vim.o.signcolumn = 'yes'

-- line break settings
vim.o.linebreak = true
vim.o.breakindent = true
vim.opt.breakindentopt = { 'shift:8', 'sbr' }

-- important to avoid preview items from auto-complete list
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- '*' highlights all same strings without jumping to next one
vim.keymap.set('n', '*', ':keepjumps normal! mi*`i<CR>')

-- turn current window to a file editor
vim.keymap.set('n', '<c-j>', ':Oil<CR>')

-- save current file
vim.keymap.set('n', '<f2>', ':w<CR>', { silent = true })
vim.keymap.set('n', '<f3>', '<c-w>x', { silent = true })
vim.keymap.set('n', '<f4>', ':q<CR>', { silent = true })

-- easy jump to words/characters
vim.keymap.set('n', '<leader>w', ':HopWord<CR>')

-- easy to browse bottom window
vim.keymap.set('n', '<leader>j', ':cnext<CR>')
vim.keymap.set('n', '<leader>k', ':cprev<CR>')

-- split/vsplit window and jump to next by using double <leader> keys
vim.keymap.set('n', '<leader>v', ':vsp<CR>')
vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader><leader>', '<c-w>w')

-- remove trailing whitespaces
vim.keymap.set('n', '<leader>x', ':StripWhitespace<CR>')
vim.keymap.set('n', ']x', ':NextTrailingWhitespace<CR>')
vim.keymap.set('n', '[x', ':PrevTrailingWhitespace<CR>')

-- format current document
vim.keymap.set('n', '<leader>=', function ()
    vim.lsp.buf.format({ async = true })
end , { silent = true })

-- close all other windows
vim.keymap.set('n', 'K', ':only<CR>')

-- hide the highlights
vim.keymap.set('n', '<leader>n', ':noh<CR>')
