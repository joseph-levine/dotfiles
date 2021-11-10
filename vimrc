let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" nginx
Plug 'chr4/nginx.vim'
" .fish
Plug 'dag/vim-fish', { 'for': 'fish' }
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
" Ansible
let g:ansible_unindent_after_newline = 1
" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" NERDTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" UltiSnips
"Plug 'SirVer/ultisnips'
" Git
Plug 'tpope/vim-fugitive'
" vim defaults - todo: replace
Plug 'tpope/vim-sensible'

" .editorconfig called last in hopes of overriding
Plug 'editorconfig/editorconfig-vim'
call plug#end()

source ~/.shared.vimrc
" Settings
set ttymouse=xterm2
set mouse=nv
set shortmess=ilnxtToO

" Commands
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
com! FormatJSON :%!python3 -m json.tool
com! TrimTrailingWhitespace :%s/\s\+$//e

" keyboard mappings (be sparing with these!)
map <C-n> :NERDTreeToggle<CR>
map <Leader>w <C-W>w

noremap <Leader>y "*y
noremap <Leader>p "*p

" autocmds (be even more sparing with these!)
" quit NERDTree if it's the last remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" turn on spell check for markdown
autocmd FileType markdown :set spell
