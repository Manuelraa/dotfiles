set termguicolors
set colorcolumn=100
autocmd FileType python setlocal colorcolumn=100

"Fromat json with "FormatJSON" cmd
com! FormatJSON %!python -m json.tool

"Press F7 for fix indention.
map <F7> gg=G<C-o><C-o>

" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
" if v:shell_error == 0
"   let venv_path = substitute(pipenv_venv_path, '\n', '', '')
"   let g:python3_host_prog = venv_path . '/bin/python'
" else
"   let g:python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python"
" endif
" "
" let g:python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python"

:call extend(g:ale_linters, {
    \'python': ['flake8'],
    \'javascript': ['eslint']})

let g:deoplete#enable_at_startup = 1
set omnifunc=ale#completion#OmniFunc

let g:polyglot_disabled = []
