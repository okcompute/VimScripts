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

" show the current the command in lower right corner
set showcmd

" Don't show the current mode 
set noshowmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Keep more stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,mark,percent,quickfix,search,tag,undo

" Have one fold open when opening a new buffer. This will reduce the number of
" Zr I do in a day.
set foldlevelstart=1

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Make the command-line completion better
set wildmenu

" ignore files
set wildignore=*.o,*.obj,*.exe,*.hi,*.tmp,*~,*.pyc,*.swp,environment,.git

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Automatically read a file that has changed on disk
set autoread

" Remove my bad habit to press :w all the time!
set autowriteall

" Automatic save when leaving insert mode (no save if file has not changed)
" Patch: Force a call to SyntasticCheck. For some reason, a check is not
" triggered on autocmd.
autocmd InsertLeave * if &buftype != "nofile" | update | execute 'SyntasticCheck' | endif 

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
imap jk <esc>

" When entering a buffer, change the current working directory
set autochdir

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

" Spelling on by default on filetype I know I will just write text...just
" english for now. Too lazy to generate the French one!
set spelllang=en
autocmd FileType doxygen,text,gitcommit setlocal spell

" Diff always vertical
set diffopt=filler,vertical

" Redraw only when we need to.
set lazyredraw 

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
    " set backupdir^=$TEMP.'\vim\backup\\',.
    " set undodir^=$TEMP.'\vim\undo\\',.
    " set directory^=$TEMP.'\vim\swap\\,.
    "
    " Main vim backup folder
    let s:temp_vim_dir = $TEMP . "/vim"
    if finddir(s:temp_vim_dir, &rtp) ==# ''
        call mkdir(s:temp_vim_dir)
    endif

    " Backup folder
    let s:backup_dir = $TEMP . "/vim/backup"
    if finddir(s:backup_dir, &rtp) ==# ''
        call mkdir(s:backup_dir)
    endif
    execute "set backupdir^=".s:backup_dir."//"

    " Undo dir
    let s:undo_dir = $TEMP . "/vim/undo"
    if finddir(s:undo_dir, &rtp) ==# ''
        call mkdir(s:undo_dir)
    endif
    execute "set undodir^=".s:undo_dir."//"

    let s:swap_dir = $TEMP . "/vim/swap"
    if finddir(s:swap_dir, &rtp) ==# ''
        call mkdir(s:swap_dir)
    endif
    execute "set directory^=".s:swap_dir."//"
endif
"}}}

" Colors, fonts and themes {{{
" =====================================
set background=dark

if has("mac")
    let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h14"
else
    let g:main_font = "Anonymous\\ Pro\\ for\\ Powerline:h13"
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

" Antialias fonts
set antialias

" Show tabs and trailing spaces
:set listchars=tab:>-,trail:-

"}}}

" Local vimrc {{{
" ===============

" Look for .local_vimrc file when opening any buffer.
" This is really cool to get settings, abbr, etc. specific to
" a project.
if !exists("g:local_vimrc")
    let g:local_vimrc = ""
endif
function! s:SetLocalVimrc()
    let local_vimrc = findfile(".local_vimrc", ".;")
    if g:local_vimrc ==? local_vimrc
        return
    endif
    if filereadable(local_vimrc)
        echo "Sourcing local .vimrc: ".local_vimrc
        exe "source ".local_vimrc
        let g:local_vimrc = local_vimrc
    endif
endfunction
autocmd BufRead * call s:SetLocalVimrc()

" Look for a .vimrc_platform when launching vim (or sourcing the vimrc).
" Specific setting for the current platform/PC/environement can be set.
" e.g.: Directory to start vim into
if has('win32') || has ('win64')
    " The file must be located in the same folder as .vimrc file
    " NOTE: gvim and .; param for findfile does not work as expected on Windows!
    " It seems that when gvim start and parse the vimrc, the path returned is
    " the path of the 'Start menu'. menu'!!. Go figure.
    let s:vimrc_platform= expand(escape($HOME, '\')."/../.vimrc_platform")
else
    " The file must be located at the same level of current .vimrc file
    " or higher (up to root).
    let s:vimrc_platform= findfile(".vimrc_platform", ".;")
endif
if filereadable(s:vimrc_platform)
    exe "source " . expand(s:vimrc_platform)
endif
"}}}

" Context specific
"==================

" Grep {{{
set grepprg=ack\ --smart-case
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
" Searches Dash for the word under your cursor in vim.
if has('mac')
function! SearchDash()
    " Some setup
    let s:browser = "/usr/bin/open"
    " Run it
    let s:url = "dash://".expand("<cword>")
    let s:cmd ="silent ! " . s:browser . " " . s:url
    execute s:cmd
    redraw!
endfunction

command! Dash :call SearchDash()<CR>
endif
"}}}

" Google search {{{
"-----------------------------------------------------------------------------
function! SearchGoogle()
    " Some setup
    let s:browser = "open"
if has('win32') || has ('win64')
    let s:browser = "cygstart"
endif
    let s:wordUnderCursor = expand("<cword>")

    " Run it
    let s:url = "https://www.google.com/search?q=".s:wordUnderCursor
    let s:cmd ="silent !".s:browser." ".s:url
    execute s:cmd
    redraw!
endfunction

command! Google :call SearchGoogle()
"}}}

" JSON {{{
" ========
autocmd BufNewFile,BufRead *.json set ft=javascript
command! Jsonify :%!python -m json.tool
"}}}

" Time {{{
" ========
" Display the time in the ex prompt
command! T echomsg strftime("%c")
"}}}

" Autopep8  {{{
" ========
" Automatically fix PEP8 issues in the current buffer.
command! Pep8 !autopep8 -i --max-line-length=120 --ignore=E24,E26 %
"}}}


" Plugins
"========

" FSwitch plugin {{{
"-----------------------------------------------------------------------------
nnoremap <silent> ,a :FSHere<CR>
let g:fsnonewfiles='off'

"}}}

" Gundo plugin {{{
"-----------------------------------------------------------------------------
nnoremap <silent> <Leader>u :GundoToggle<CR>

"}}}

" Powerline plugin {{{
"-----------------------------------------------------------------------------
set encoding=utf-8
python << EOF
from powerline.vim import setup as powerline_setup
powerline_setup()
del powerline_setup
EOF
"}}}

" UltiSnips plugin {{{
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
"}}}

" Matchit plugin {{{
"-----------------------------------------------------------------------------
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif
"}}}

" PythonMode {{{
let g:pymode_lint = 0
let pymode_rope=0
let g:pymode_syntax=0
"}}}

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctags']
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(\.git|\.hg|\.svn|environment|external|Build|buildfolder|pydev|memcached|Logs|dependencies|UserDoc|Extern|Doc|Images)$',
  \ 'file': '\v(\.exe|\.so|\.dll|\.pdb|\.sln|\.suo|tags|\.csproj|\.txt|\.dox|\.jpg|\.jpeg|\.gif|\.png|\.bpt|\.tlog|\.pdf)$',
  \ 'link': '',
  \ }
let g:ctrlp_max_height = 20
" No limits on files
let g:ctrlp_max_files = 0
" Unlimited depth
let g:ctrlp_max_depth = 100
let g:ctrlp_buftag_types = {
            \ 'objc'     : '--langdef=objc --langmap=objc:.m.h',
            \ }
nnoremap <silent> <Leader>ff :CtrlP<CR>
nnoremap <silent> <Leader>fb :CtrlPBuffer<CR>
nnoremap <silent> <Leader>ft :CtrlPTag<CR>
nnoremap <silent> <Leader>fc :CtrlPBufTag<CR>
"}}}

" Syntastic {{{
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E124'
"}}}

" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0
"}}}

" Python-syntax {{{
let python_highlight_all = 1
autocmd BufEnter *.py let b:python_version_2 = 1
"}}}

" Doxygen-syntax {{{
au BufNewFile,BufRead *.dox,*doxygen setfiletype doxygen
"}}}
