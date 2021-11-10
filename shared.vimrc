" Shared
let mapleader = "\<space>"
let g:is_posix = 1
set fixendofline
vnoremap <Leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>
