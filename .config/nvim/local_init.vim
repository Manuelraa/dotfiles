"Fromat json with "FormatJSON" cmd
com! FormatJSON %!python -m json.tool

"Press F7 for fix indention.
map <F7> gg=G<C-o><C-o>

"Mouse support
set mouse=a

"
let g:python3_host_prog = "/home/user/.pyenv/versions/neovim3/bin/python"
set omnifunc=ale#completion#OmniFunc
