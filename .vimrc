call plug#begin('~/.vim/plugged')
Plug 'chr4/nginx.vim'
Plug 'editorconfig/editorconfig-vim'
" Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-sensible'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --cs-completer --rust-completer --ts-completer' }
call plug#end()

let g:is_posix = 1
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
