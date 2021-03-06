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

" Settings
let g:is_posix = 1
set fixendofline

" Leader
let mapleader = "\<space>"

" Commands
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
com! FormatJSON :%!python3 -m json.tool
com! TrimTrailingWhitespace :%s/\s\+$//e

" keyboard mappings (be sparing with these!)
map <C-n> :NERDTreeToggle<CR>
map <Leader>w <C-W>w

vnoremap <Leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

" autocmds (be even more sparing with these!)
" quit NERDTree if it's the last remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
