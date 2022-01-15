" ---- Plugins setup ----
lua << EOF
require('plugins')
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end
-- Setup nvim-cmp.
local cmp = require('cmp')
cmp.setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
  end,
  completion = {
    autocomplete = {},
  },
  mapping = {
    ['<C-L>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
    local opts = { on_attach = on_attach, capabilities = capabilities }
    server:setup(opts)
end)
EOF
" ---- end of Plugins setup ----

" ---- Common settings ----
set nu
set noshowmode
set showtabline=0
set cursorline
set cinkeys-=:
set linebreak
set breakindent
set breakindentopt=shift:4
set updatetime=200
" ---- Common shortcuts ----
let mapleader = ';'
noremap N :noh<CR>
noremap * :keepjumps normal! mi*`i<CR>
" ---- end of Common settings ----

" ---- Local vimrc settings ----
let g:localvimrc_ask = 0
" ---- end of Local vimrc settings ----

" ---- Color scheme `gruvbox` ----
if has('termguicolors')
    set termguicolors
endif
let g:gruvbox_background = 'dark'
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
" ---- end of Color scheme `gruvbox` ----

" ---- Color scheme `gruvbox` for lightline
let g:lightline = {
            \ 'colorscheme': 'gruvbox_material',
            \ 'active': {'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]},
            \ 'component_function': {'gitbranch': 'FugitiveHead'}}
" ---- end of Color scheme `gruvbox` for lightline

" ---- TrailerTrim settings ----
noremap <C-T> :StripWhitespace<CR>
" ---- end of TrailerTrim settings ----

" ---- Fugitive settings ----
noremap <C-G> :Git<CR>
" ---- end of Fugitive settings ----

" ---- CTags settings ----
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_generate_on_missing = 1
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_ctags_exclude = ['node_modules']
let g:gutentags_cache_dir=s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude=node_modules']
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif
" ---- end of CTags settings ----

" ---- LeaderF related settings ----
let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WildIgnore={
            \ 'dir': ['.svn','.git','.hg','node_modules'],
            \ 'file': ['*.sw?','*.bak','*.exe','*.o','*.so']
            \}
let g:Lf_StlSeparator={'left': '', 'right': '', 'font': ''}
let g:Lf_RootMarkers=['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode='Ac'
let g:Lf_CacheDirectory=expand('~/.vim/cache')
let g:Lf_ShowRelativePath=0
let g:Lf_PreviewResult={'Function':0, 'BufTag':0}
let g:Lf_ShortcutF='<C-P>'
let g:Lf_ShowDevIcons=0
noremap <Leader>o :LeaderfFunction<CR>
noremap <Leader>g :LeaderfTag<CR>
" ---- end of LeaderF related settings ----

" ---- Neoformat settings ----
noremap C :Neoformat<CR>
" ---- end of Neoformat settings ----

" ---- Switch header/source settings ----
let g:fsnonewfiles = 'on'
noremap <C-H> :FSHere<CR>
" ---- end of Switch header/source settings ----

" ---- NERDTree settings ----
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 35
" Will close vim if there is only a nerdtree window exists
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Nerd tree command
function OpenNERDTree()
    if bufname('%') == ''
        :NERDTree
    else
        :NERDTreeFind
    endif
endfunction
noremap <C-J> :call OpenNERDTree()<CR>
" ---- end of NERDTree settings ----

" ---- AsyncRun settings ----
let g:asyncrun_open = 20
let g:asyncrun_bell = 1
noremap M :cclose<CR>:lclose<CR>:pclose<CR>
noremap gu :AsyncRun git push<CR>
noremap <C-K> :AsyncStop<CR>
function Build()
    if !empty(expand(glob("Makefile")))
        :AsyncRun make -j9
    else
        :AsyncRun cmake --build ./build --config debug -j9
    endif
endfunction
function Clean()
    if !empty(expand(glob("Makefile")))
        :AsyncRun make clean
    else
        :AsyncRun cmake --build ./build --target clean
    endif
endfunction
noremap mk :call Build()<CR>
noremap mc :call Clean()<CR>
noremap <Leader>n :cn<CR>
noremap <Leader>p :cp<CR>
" ---- end of AsyncRun settings ----
