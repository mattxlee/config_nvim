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
    buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
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
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
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
    -- ccls
    if server.name == "ccls" then
        opts.init_options = {
            highlight = { lsRanges = true };
            compilationDatabaseDirectory = "./build/";
        }
    end
    server:setup(opts)
end)
-- Other setups
require("nvim-tree").setup({
    update_cwd = true,
    actions = { open_file = { quit_on_open = true } }
})
require("workspaces").setup({
    hooks = {
        open = "silent! %bd"
    }
})
EOF
" ---- end of Plugins setup ----

" ---- Common settings ----
set nu
set noshowmode
set showtabline=0
set updatetime=100
set cursorline
set linebreak
set breakindent
set breakindentopt=shift:4
set guifont=Hack\ NF:h12
set cinkeys-=:
set nobackup
set nowritebackup
set noswapfile
let c_no_curly_error=1
if has('termguicolors')
    set termguicolors
endif
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" ---- Common shortcuts ----
let mapleader='\'
noremap <C-J> :NvimTreeToggle<CR>
noremap N :noh<CR>
noremap * :keepjumps normal! mi*`i<CR>
noremap K :on<CR>
noremap <Leader>s :sp<CR>
noremap <Leader>v :vsp<CR>
noremap <Leader>w <C-W>w
noremap <Leader>h :vertical resize 130<CR>
noremap <Leader><Leader>r :NvimTreeRefresh<CR>
noremap <Leader><Leader>d :%bd<CR>
" ---- end of Common settings ----

" ---- Color scheme ----
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1
silent! colorscheme gruvbox
" ---- end of Color scheme ----

" ---- Header/Source switcher settings ----
let g:alternateNoDefaultAlternate=1
" ---- end of Header/Source switcher settings ----

" ---- Markdown settings ----
let g:vim_markdown_folding_disabled=1
" ---- end of Markdown settings ----

" ---- TrailerTrim settings ----
noremap <C-T> :StripWhitespace<CR>
" ---- end of TrailerTrim settings ----

" ---- Fugitive settings ----
noremap <C-G> :Git<CR>
" ---- end of Fugitive settings ----

" ---- Workspaces settings ----
noremap <Leader>a :WorkspacesOpen<CR>
noremap <Leader><Leader>a :WorkspacesAdd
" ---- end of Workspaces settings ----

" ---- ToggleTerm settings ----
noremap <Leader>t :ToggleTerm direction=float<CR>
" ---- end of ToggleTerm settings ----

" ---- CTags settings ----
let g:gutentags_project_root=['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile='.tags'
let g:gutentags_generate_on_empty_buffer=1
let g:gutentags_generate_on_missing=1
let s:vim_tags=expand('~/.cache/tags')
let g:gutentags_ctags_exclude=['node_modules', '.ccls-cache']
let g:gutentags_cache_dir=s:vim_tags
let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args+=['--c++-kinds=+px']
let g:gutentags_ctags_extra_args+=['--c-kinds=+px']
let g:gutentags_exclude_filetypes=['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif
" ---- end of CTags settings ----

" ---- LeaderF related settings ----
let g:Lf_WindowPosition='popup'
let g:Lf_PreviewInPopup=1
let g:Lf_ShortcutF='<C-P>'
let g:Lf_WildIgnore={
            \ 'dir': ['.svn','.git','.hg','.ccls-cache','node_modules','build'],
            \ 'file': ['*.sw?','*.bak','*.exe','*.o','*.so']
            \}
let g:Lf_StlSeparator={'left': '', 'right': '', 'font': ''}
let g:Lf_RootMarkers=['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode='Ac'
let g:Lf_CacheDirectory=expand('~/.vim/cache')
let g:Lf_ShowRelativePath=0
let g:Lf_PreviewResult={'Function':0, 'BufTag':0}
let g:Lf_ShowDevIcons=1
noremap <Leader>o :LeaderfFunction<CR>
noremap <Leader>g :LeaderfTag<CR>
" ---- end of LeaderF related settings ----

" ---- Editorconfig settings ----
let g:EditorConfig_preserve_formatoptions=1
let g:EditorConfig_max_line_indicator="fill"
" ---- end of Editorconfig settings ----

" ---- Neoformat settings ----
noremap C :Neoformat<CR>
" ---- end of Neoformat settings ----

" ---- Switch header/source settings ----
let g:fsnonewfiles='on'
noremap <C-H> :silent A<CR>
" ---- end of Switch header/source settings ----

" ---- Startify settings ----
let g:startify_change_to_vcs_root=1
" ---- end of Startify settings ----

" ---- AsyncRun settings ----
let g:asyncrun_open=20
let g:asyncrun_bell=1
noremap M :cclose<CR>:lclose<CR>:pclose<CR>
noremap gu :Git push<CR>
noremap <C-K> :AsyncStop<CR>
function Build()
    if !empty(expand(glob("Makefile")))
        :AsyncRun make
    else
        :AsyncRun cmake --build ./build --config debug
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
noremap mn :call Clean()<CR>
noremap <Leader>n :cn<CR>
noremap <Leader>p :cp<CR>
" ---- end of AsyncRun settings ----
