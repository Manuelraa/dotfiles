set termguicolors
set colorcolumn=100

"Fromat json with "FormatJSON" cmd
com! FormatJSON %!python -m json.tool

"Press F7 for fix indention.
map <F7> gg=G<C-o><C-o>

"
let g:python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python"
"let g:python2_host_prog = "$HOME/.pyenv/versions/neovim2/bin/python"

:call extend(g:ale_linters, {
    \'python': ['flake8'],
    \'javascript': ['eslint']})

let g:deoplete#enable_at_startup = 1
"set omnifunc=ale#completion#OmniFunc
"let g:ale_completion_enabled = 1
