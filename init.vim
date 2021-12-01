lua require('plugins')

" ---- Common settings ----
set nu
let mapleader = ';'
noremap N :noh<CR>
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
