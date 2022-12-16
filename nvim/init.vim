let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dmerejkowsky/vim-ale'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

source ~/.shared.vimrc
" Settings
set shortmess=ilnxtToO
set nohlsearch

" Commands
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
com! FormatJSON :%!python3 -m json.tool
com! TrimTrailingWhitespace :%s/\s\+$//e

" keyboard mappings (be sparing with these!)
noremap <Leader>y "*y
noremap <Leader>p "*p

" autocmds (be even more sparing with these!)
" turn on spell check for markdown
autocmd FileType markdown setlocal spell
autocmd FileType nginx setlocal shiftwidth=4 tabstop=4 expandtab
