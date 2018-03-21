set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

nnoremap <buffer> <silent> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
nnoremap <buffer> <silent> <leader>s :<C-U>call PSCIDEapplySuggestion()<CR>
let g:loaded_youcompleteme = 1
