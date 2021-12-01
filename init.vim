lua require('plugins')

" ---- Common settings ----
set nu
" ---- end of Common settings ----

" ---- Color scheme `gruvbox` ----
if has('termguicolors')
    set termguicolors
endif
let g:gruvbox_background = 'dark'
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
" ---- end of Color scheme `gruvbox` ----

" ---- Color scheme `gruvbox` for lightline
let g:lightline = {'colorscheme': 'gruvbox_material'}
" ---- end of Color scheme `gruvbox` for lightline

" ---- Fugitive settings ----
noremap <C-G> :Git<CR>
noremap gu :Git push<CR>
" ---- end of Fugitive settings ----

" ---- LeaderF related settings ----
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = '<C-P>'
" ---- end of LeaderF related settings ----

" ---- Neoformat settings ----
noremap C :Neoformat<CR>
" ---- end of Neoformat settings ----

" ---- Switch header/source settings ----
noremap <C-H> :A<CR>
" ---- end of Switch header/source settings ----
