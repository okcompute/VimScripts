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

" Make sure that unsaved buffers that are to be put in the background are 
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Set the status line
set stl=%f\ %m\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

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
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

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

" disable toolbar
set guioptions-=T

" Configure the tags file  rule. 
set tags=./tags;

"}}}

" Windows {{{
"=================

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
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
    "
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

elseif has('win32') || has ('win64')

    " Remove the current directory from the backup directory list.
    "
    set backupdir-=.

    " Save backup files in the current user's TEMP directory
    " (that is, whatever the TEMP environment variable is set to).
    "
    set backupdir^=$TEMP

    " Put swap files in TEMP, too.
    "
    set directory=$TEMP\\\\

endif

let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'

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

" Python {{{

" Pydoc script location
let g:pydoc_cmd = "pydoc"

"}}}

" Plugins
"========

" Clang_complete {{{

" Blocks are not enabled by default in clang. Cocoa frameworks use them
" extensively.
"if has('mac')
    "let g:clang_user_options='-fblocks -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk -D__IPHONE_OS_VERSION_MIN_REQUIRED=50000 -fobjc-arc' 
"endif

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

"" Limit popup menu height
set pumheight=15

"" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 1

" Show clang errors in the quickfix window
let g:clang_complete_copen = 1

" Check for clang errors from time to time
let g:clang_periodic_quickfix = 1

"" The quotes at the beggining of clang_exec and at the end of clang_user_options are important, don't remove them
"" They basically trick vim into thinking clang executed fine, because the msvc build autocompletes correctly but fails
"" to compile.
"" Don't forget to put paths with spaces in quotes other wise vim won't be able to execute the command
"if has('win32') || has ('win64')
    "let g:clang_exec = '"clang'
    "let g:clang_user_options = '-ID:/perforce/online/team/dev_branches/UserStorage/OnlineSDK/. 2>NUL || exit 0"'
"endif

let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'

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

