set clipboard=
colorscheme gruvbox 

"Fromat json with "FormatJSON" cmd
com! FormatJSON %!python -m json.tool

"Press F7 for fix indention.
map <F7> gg=G<C-o><C-o>


"==============
"SYNTASTIC
"==============
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']


"==============
"YOUCOMPLETEME
"==============
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
if v:shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python3'
  let g:python3_host_prog = venv_path . '/bin/python3'
else
  let g:ycm_python_binary_path = 'python3'
endif
