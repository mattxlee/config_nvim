lua require('plugins')

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

