nnoremap <Tab> >>_
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-TAB> <gv

" System clipboard

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" auto-expand
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" NERDTree
map <C-g> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0

" fzf
map ; :Files<CR>
