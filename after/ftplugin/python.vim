" Folding 
setlocal foldmethod=syntax

" Pydoc script location
let g:pydoc_cmd = "pydoc"

" Override functions/methods/class navigations. I find it more simple to use
" ]] and [[ mapping as generic motion
nnoremap <buffer> ]]  :<C-U>call pymode#motion#move('^\s*\(class\\|def\)\s', '')<CR>
nnoremap <buffer> [[  :<C-U>call pymode#motion#move('^\s*\(class\\|def\)\s', 'b')<CR>
onoremap <buffer> ]]  :<C-U>call pymode#motion#move('^\(class\\|def\)\s', '')<CR>
onoremap <buffer> [[  :<C-U>call pymode#motion#move('^\(class\\|def\)\s', 'b')<CR>
vnoremap <buffer> ]]  :call pymode#motion#vmove('^\s*\(class\\|def\)\s', '')<CR>
vnoremap <buffer> [[  :call pymode#motion#vmove('^\s*\(class\\|def\)\s', 'b')<CR>

