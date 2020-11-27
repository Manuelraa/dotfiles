Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-jedi'
if executable('ansible')
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
endif
Plug 'neoclide/coc.nvim', {'branch': 'release'}
