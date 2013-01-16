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
set autowrite
"
" More to remove the need for pressing :w all the time.
" This will save when leaving the insert mode and only if there were changes
:autocmd InsertLeave <buffer> update 

" Make sure the line are displayed
set number

" System default for mappings is now the "," character
let mapleader = ","

" Turn off highlight search
nmap <silent> ,n :nohls<CR>

" Show all available VIM servers
nmap <silent> ,ss :echo serverlist()<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Search the current file for what's currently in the search register and display matches
nmap <silent> ,gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Toggle fullscreen mode
if has('win32') || has ('win64')
    nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" Override the ESC to jk so my hands stays on the keyboard home row
imap jk <esc>

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

let g:netrw_list_hide= 'tags, .*\.swp$,.*\.pyc$'

" Allow color schemes do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

"}}}

" Windows {{{
"============

" Maps to make handling windows a bit easier
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-l> :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J

" Close the buffer but not the window...one 'annoyance' of Vim fixed :) Found
" this on stackoverflow
nmap <leader>d :bprevious<CR>:bdelete #<CR>

"}}}
"
" Backup files and directories {{{
"==================================

set backup

" All backup files at the same place. Don't like having .swp or .~ files everywhere
" on my system
" Prepend OS-appropriate temporary directories to the backupdir list.

if has("unix") " (including OS X)

    " Remove the current directory from the backup directory list.
    set backupdir-=.

    " Save backup files in the current user's ~/tmp directory, or in the
    " system /tmp directory if that's not possible.
    "
    set backupdir^=~/tmp,/tmp

    " Try to put swap files in ~/tmp (using the munged full pathname of
    " the file to ensure uniqueness). Use the same directory as the
    " current file if ~/tmp isn't available.
    "
    set directory=~/tmp//,.

    " Save undo file. With this, no need to set hidden. I like it when Vim tells
    " me I forgot to save a file.
    set undofile
    set undodir^=~/.vim/undodir

elseif has('win32') || has ('win64')

    " Remove the current directory from the backup directory list.
    set backupdir-=.

    " Save backup files in the current user's TEMP directory
    " (that is, whatever the TEMP environment variable is set to).
    "
    set backupdir^=$TEMP

    " Put swap files in TEMP, too.
    "
    set directory=$TEMP\\\\

    " Save undo file. With this, no need to set hidden. I like it when Vim tells
    " me I forgot to save a file.
    set undofile
    set undodir^=$TEMP/vim/undodir

endif


"}}}

" Set up fonts {{{
"-----------------------------------------------------------------------------
if has("mac")
    let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h14"
else
  let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h13"
endif

"}}}

" Colors, fonts and themes {{{
" =====================================
if has("gui_running")
    exe "set guifont=" . g:main_font
    set background=dark
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
endif
:nohls


" Directory. Ignore these files
" Select the color scheme
::colorscheme wombat

"}}}

" Local vimrc {{{
let b:vim_local = findfile($HOME."/../_vimrc_local", &rtp)
if filereadable(b:vim_local)
    exe "source ".b:vim_local
endif
"}}}

" Context specific
"==================

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

" FuzzyFinder plugin {{{
"-----------------------------------------------------------------------------
nnoremap <silent> <Leader>ft :FufTag<CR>
nnoremap <silent> <Leader>ff :VimProjFuzzyFindFiles<CR>
nnoremap <silent> <Leader>fb :FufBuffer<CR>

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

" Syntastic plugin {{{
"-----------------------------------------------------------------------------
" Add info in the status line (this will only show when powerline is not used)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

let g:syntastic_check_on_open=1
let g:syntastic_python_checker="flake8"
let g:syntastic_quiet_warnings=1
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
map K :call SearchDash()<CR>
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

" PythonMode {{{
let g:pymode_lint_cwindow=0
let g:pymode_lint_onfly=1
let g:pymode_lint_ignore="E124,E501"
"}}}
