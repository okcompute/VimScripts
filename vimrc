" vim:fdm=marker

" Vim
"====

" Global Stuff {{{
"=================

set nocompatible

" Get pathogen up and running
filetype off 
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Set the HOME 
if has('win32') || has ('win64')
    let $HOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" ignore case when searching
set ignorecase

" but allow to search with upper case when i want to
set smartcase

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Set the status line
set statusline=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" show the current the command in lower righ corner
set showcmd

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
"set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" Keep more stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Make the command-line completion better
set wildmenu

" ignore files
set wildignore=*.o,*.obj,*.exe,*.hi,*.tmp,*~,*.pyc,*.swp

" Enable search highlighting
set hlsearch

" Incrementally match the search  
set incsearch

" Automatically read a file that has changed on disk
set autoread

" Remove my bad habit to press :w all the time!
set autowriteall

" Make sure the line are displayed
set number

" System default for mappings is now the "," character
let mapleader = ","

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Toggle fullscreen mode
if has('win32') || has ('win64')
    nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" Override the ESC to jk so my hands stays on the keyboard home row
imap jk <esc>:w<CR>

" When entering a buffer, change the current working directory
autocmd BufEnter * cd %:p:h

" disable toolbar, menu and all scrollbars...this gonna be pure stuff :)
set guioptions=g

" Configure the tags file  rule. 
set tags=./tags;

" Save lots of info to get restored when starting Vim again.
set viminfo^=!

" Briefly show the matching paratheses, brackets, ...
set showmatch

" Add the mac fileformat as the possibilities
set fileformats+=mac

" Hide rule for netrw file browser
let g:netrw_list_hide= '^tags$,.*\.swp$,.*\.pyc$,^\.ctags$,^\.gitignore$,^\.git\/$,^\.DS_Store$'

" Try listchars settings from tpope's sensible.vim
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
        let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
    endif
endif

"}}}

" Backup files and directories {{{
"==================================

set backup
set undofile

" All backup files at the same place. Don't like having .swp or .~ files everywhere
" on my system
if has("unix") " (including OS X)
    " Save backup files in the current user's ~/tmp directory, or in the
    " system /tmp directory if that's not possible.
    set backupdir^=~/tmp,/tmp

    " Try to put swap and undo files in ~/tmp (using the munged full pathname of
    " the file to ensure uniqueness). Use the same directory as the
    " current file if ~/tmp isn't available.
    set directory^=~/tmp//,.
    set undodir^=~/tmp//,.

elseif has('win32') || has ('win64')
    " Save backup , swap and undo files in the current user's TEMP directory
    " (that is, whatever the TEMP environment variable is set to).
    " If not available, use the current directory. 
    set backupdir^=$TEMP,.
    set undodir^=$TEMP,.
    set directory^=$TEMP,.

endif
"}}}

" Colors, fonts and themes {{{
" =====================================
set background=dark

if has("mac")
    let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h14"
else
    let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h12"
endif

if has("gui_running")
    exe "set guifont=" . g:main_font

    " Select the color scheme
    colorscheme wombat
    if !exists("g:vimrcloaded")
        winpos 0 0
        if !&diff
            winsize 130 120
        else
            winsize 227 120
        endif
        let g:vimrcloaded = 1
    endif
else
    colorscheme wombat256mod
endif

" Allow color schemes do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
    set t_Co=16
endif

"}}}

" Local vimrc {{{

" Look for .local_vimrc file when opening any buffer.
" This is really cool to get settings, abbr, etc. specific to 
" a project.
function! s:SetLocalVimrc()
    let local_vimrc = findfile(".local_vimrc", ".;")
    if filereadable(local_vimrc)
        exe "source ".local_vimrc
    endif
endfunction
autocmd BufNewFile,BufRead * call s:SetLocalVimrc()

" Look for a .platform_vimrc when launching vim (or sourcing the vimrc).
" Specific setting for the current platform/PC/environement can be set.
" e.g.: Directory to start vim into
" The file must be located at the same level of current .vimrc file 
" or higher (up to root).
let s:platform_vimrc= findfile($HOME."/../.platform_vimrc", &rtp)
if filereadable(s:platform_vimrc)
    exe "source ".s:platform_vimrc 
endif
"}}}

" Context specific
"==================

" Grep {{{
if has('win32') || has ('win64')
    " Print line number (duh!) and make it recursive by default since ** doesn't work
    " with findstr
    set grepprg=findstr\ /n\ /s
endif
"}}}

" Text files {{{

" When editing text file, add the accents keymap
autocmd BufEnter *.txt setlocal keymap=accents

"}}}

" Perforce {{{
let s:IgnoreChange=0
autocmd! FileChangedRO * nested
            \ let s:IgnoreChange=1 |
            \ call system("p4 edit " . expand("%")) |
            \ set noreadonly
autocmd! FileChangedShell *
            \ if 1 == s:IgnoreChange |
            \   let v:fcs_choice="" |
            \   let s:IgnoreChange=0 |
            \ else |
            \   let v:fcs_choice="ask" |
            \ endif
"}}}

" Dash search {{{

"-----------------------------------------------------------------------------
" Searches Dash for the word under your cursor in vim, using the keyword 
" operator, based on file type. E.g. for JavaScript files, I have it 
" configured to search j:term, which immediately brings up the JS doc
" for that keyword. Might need some customisation for your own keywords!
function! SearchDash()
    " Some setup
    let s:browser = "/usr/bin/open"
    let s:wordUnderCursor = expand("<cword>")

    " Get the filetype (everything after the first ., for special cases
    " such as index.html.haml or abc.css.scss.erb)
    let s:fileType = substitute(expand("%"),"^[^.]*\.","",1)

    " Alternative ways of getting filetype, aborted
    " let s:fileType = expand("%:e")
    " let s:searchType = b:current_syntax.":"

    " Match it and set the searchType -- make sure these are the right shortcuts
    " in Dash! Sort by priority in the match list below if necessary, because
    " Tilt-enabled projects may have endings like .scss.erb. 
    if match(s:fileType, "js") != -1
        let s:searchType = "js:"     " can assign this to jQuery, too
    elseif match(s:fileType, "css") != -1
        let s:searchType = "css:"
    elseif match(s:fileType, "html") != -1
        let s:searchType = "html:"
    elseif match(s:fileType, "rb") != -1
        let s:searchType = "rb:"    " can assign this to Rails, too
    elseif match(s:fileType, "php") != -1
        let s:searchType = "php:"
    elseif match(s:fileType, "py") != -1
        let s:searchType = "python:"
    else
        let s:searchType = ""
    endif

    " Run it
    let s:url = "dash://".s:searchType.s:wordUnderCursor
    let s:cmd ="silent ! " . s:browser . " " . s:url
    execute s:cmd
    redraw!
endfunction

if has('mac')
    nnoremap <leader>k :call SearchDash()<CR>
endif
"}}}

" Google search {{{
"-----------------------------------------------------------------------------

" Searches Google for the word under your cursor
function! SearchGoogleWindows()
    Some setup
    " let s:browser = "C:\\Program Files (x86)\\Safari\\safari.exe"
    let s:browser = "c:\\progra~2\\safari\\safari.exe"
    let s:wordUnderCursor = expand("<cword>")

    " Run it
    let s:url = "https://encrypted.google.com/search?q=". s:wordUnderCursor
    let s:cmd ="silent ! ".s:browser." ".s:url
    execute s:cmd
    redraw!
endfunction

function! SearchGoogle()
    " Some setup
    let s:browser = "open"
    let s:wordUnderCursor = expand("<cword>")

    " Run it
    let s:url = "https://encrypted.google.com/search?q=". s:wordUnderCursor
    let s:cmd ="!".s:browser." ".s:url
    execute s:cmd
    redraw!
endfunction

if has('win32') || has ('win64')
    map <leader>g :call SearchGoogleWindows()<CR>
else
    map <leader>g :call SearchGoogle()<CR>
endif
"}}}

" JSON {{{
"-----------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.json set ft=javascript
"}}}

" Plugins
"========

" Clang_complete {{{

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

"" Limit popup menu height
set pumheight=15

"" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 1

if has("mac")
    " Check for clang errors from time to time
    let g:clang_periodic_quickfix = 1

    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
endif

"}}}

" SuperTab plugin {{{

" Disable supertab in text file. Was annoying!
autocmd BufEnter *.txt let b:SuperTabDisabled=1

"" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

"}}}

" FSwitch plugin {{{
"-----------------------------------------------------------------------------
nnoremap <silent> ,a :FSHere<CR>

"}}}

" Gundo plugin {{{
"-----------------------------------------------------------------------------
nnoremap <silent> <Leader>u :GundoToggle<CR>

"}}}

" Powerline plugin {{{
"-----------------------------------------------------------------------------
let g:Powerline_symbols = 'fancy'
set encoding=utf-8

"}}}

" UltiSnips plugin {{{
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"}}}

" Matchit plugin {{{
"-----------------------------------------------------------------------------
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif
"}}}

" PythonMode {{{
let g:pymode_lint_cwindow=0
let g:pymode_lint_onfly=1
let g:pymode_lint_ignore="E124,E501"
let pymode_rope=0
"}}}

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctags']
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pdb|sln|suo)|(tag)$',
  \ 'link': '',
  \ }
let g:ctrlp_max_height = 20
nnoremap <silent> <Leader>ff :CtrlP<CR>
nnoremap <silent> <Leader>fb :CtrlPBuffer<CR>
nnoremap <silent> <Leader>ft :CtrlPTag<CR>
nnoremap <silent> <Leader>fc :CtrlPBufTag<CR>

"}}}
