set nocompatible              " be iMproved
filetype off                  " required!

let config_dir = $HOME . "/.vim"
let config_haskell = expand(resolve(config_dir . "/vimrc.haskell"))

" Plugins {{{
call plug#begin('~/.vim/plugged')

" Support bundles
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/gitignore'

" Git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
"Plug 'kien/ctrlp.vim'

" Text manipulation
Plug 'vim-scripts/Align'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'

" Haskell
"Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
"Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
"Plug 'dan-t/vim-hsimport', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
"Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
Plug 'godlygeek/tabular', { 'for': 'haskell' }

"Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'kchmck/vim-coffee-script'
Plug 'digitaltoad/vim-jade'
"Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'shime/vim-livedown'
Plug 'wavded/vim-stylus'
"Plug 'lambdatoast/elm.vim'
Plug 'szw/vim-ctrlspace'
Plug 'scrooloose/syntastic'
"Plug 'leafgarland/typescript-vim'
"Plug 'Quramy/tsuquyomi'
Plug 'mbbill/undotree'
Plug 'vim-ruby/vim-ruby'
Plug 'easymotion/vim-easymotion'

" Clojure
Plug 'guns/vim-clojure-static'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fireplace'

" SnipMate
Plug 'MarcWeber/vim-addon-mw-utils' " dependency of SnipMate
Plug 'tomtom/tlib_vim'              " dependency of SnipMate
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'           " collection of snippets

" Purescript
Plug 'raichoo/purescript-vim'
Plug 'frigoeu/psc-ide-vim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

call plug#end()
" }}}

" General {{{

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" Disble vim-gitgutter keybindings
let g:gitgutter_map_keys = 0

" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" }}}

" Completion {{{

set completeopt+=longest
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" }}}

" Git {{{
let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gg :copen<cr>:GGrep
nnoremap <leader>gl :Extradite!<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :GBlame<cr>

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

nnoremap <C-E> :NERDTreeToggle<CR>
nnoremap ,n :NERDTreeFind<cr>

" }}}

" Alignment {{{

let g:loaded_AlignMapsPlugin=1

" Align on equal signs
map <leader>a= :Align =<cr>
" Align on commas
map <leader>a, :Align ,<cr>
" Align on pipes
map <leader>a<bar> :Align <bar><cr>
" Prompt for align character
map <leader>ap :Align

" }}}

" Editing mappings {{{

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless file is already
" using tabs, in which case tabs will be inserted.
set shiftwidth=2
set softtabstop=2
set tabstop=2

set textwidth=80
set smarttab

set ai " Auto indent
set si " Smart indent

" }}}

" Open window splits in various places
nnoremap <leader>sh :leftabove  vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove  new<CR>
nnoremap <leader>sj :rightbelow new<CR>

noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l

" Always show airline
set laststatus=2

" Enable colors
syntax enable
if has('gui_running')
    set background=light
    set macmeta
else
    set background=light
endif
let g:solarized_termcolors=256
colorscheme solarized

set guifont=Menlo:h13

set ruler
set ttyfast
set autoread
set more
set cursorline!
set number

set listchars=nbsp:¬,tab:»·,trail:·
set list

" Go
augroup golang
  au!
  au Filetype go setlocal listchars+=tab:\ \ 
  au Filetype go nnoremap <leader>d :sp <CR>:exe "GoDef"<CR>
  au Filetype go nnoremap <leader>r :GoRun %<CR>
  au Filetype go nnoremap <leader>b :GoBuild<CR>
augroup END

let g:go_fmt_command = "goimports"

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" No annoying sound on errors
set noerrorbells
set novisualbell
set timeoutlen=500
" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Starting from vim 7.3 undo can be persisted across sessions
" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/c2onmqe
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

let g:ctrlp_map = '<c-p>'
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set hidden
set switchbuf=useopen

nnoremap <Leader>r :.,$s/\<<C-r><C-w>\>/
nnoremap <Leader>s :/\<<C-r><C-w>\><cr>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap K :Ag<space>
nnoremap <leader>q :ccl<cr>

augroup MyAutoCmd
    autocmd!
    autocmd MyAutoCmd BufWritePost .vimrc nested source $MYVIMRC
    autocmd MyAutoCmd BufWritePost init.vim nested source $MYVIMRC
    autocmd MyAutoCmd BufWritePost vimrc.haskell nested source $MYVIMRC
augroup END

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>es :e ~/.ssh/config<cr>
nnoremap <leader>et :e ~/.tmux.conf<cr>
nnoremap <leader>eh :e ~/.vim/vimrc.haskell<cr>

nnoremap <leader>bd :Bufonly<cr>
nnoremap <leader>gb :Gblame<cr>

autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Easy buffer navigation
function! s:HasCtrlSpace()
    for plug in g:plugs_order
        if plug == "vim-ctrlspace"
            return 1
        endif
    endfor

    return 0
endfunction

let s:ctrlspace = s:HasCtrlSpace()
if s:ctrlspace
    nnoremap <C-j> :CtrlSpaceGoUp<cr>
    nnoremap <C-k> :CtrlSpaceGoDown<cr>
else
    nnoremap <C-j> :bprevious<cr>
    nnoremap <C-k> :bnext<cr>
endif

" close file fix
" nnoremap <Leader>x :bd<cr>
nnoremap <Leader>x :bp<cr>:bd #<cr>

if v:version >= 700
    au BufLeave * if !&diff | let b:winview = winsaveview() | endif
    au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | endif
endif

augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

nnoremap / /\v
vnoremap / /\v

nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>

nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

nnoremap ; :
nnoremap : ;

nnoremap <F7> mzgg=G`z

nnoremap I $a<cr>

set backspace=indent,eol,start
set relativenumber

" Removes trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <leader>rts :call TrimWhiteSpace()<cr>

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

let &colorcolumn=join(range(101,999),",")
set clipboard=unnamed

" ctrlspace settings
nnoremap <silent><C-p> :CtrlSpace O<CR>
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1

" livedown
nnoremap gm :LivedownToggle<cr>
let g:livedown_port = 1337
let g:livedown_browser = "open /Applications/Google\ Chrome.app"

" syntastic
nnoremap <leader>zz :lopen<cr>
nnoremap <leader>zn :lnext<cr>
nnoremap <leader>zp :lprev<cr>

" coffee compile
"nnoremap <leader>cc :CoffeeCompile<cr>
"vnoremap <leader>cc :CoffeeCompile<cr>

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 7
let g:syntastic_always_populate_loc_list = 1

" typescript-vim
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow

" neomake
let g:neomake_coffeescript_enabled_makers = ['coffeelint']
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake
let g:neomake_list_height=5

" UndoTree
nnoremap <F5> :UndotreeToggle<cr>

" Mocha .only
function! Mocha_Toggle_Only()
    let keywords = ['it', 'describe', 'context']
    let keywordsGroup = join(keywords, '\|')
    let only = '^\s*\('.keywordsGroup.'\)\.only'
    let noOnly = '^\s*\('.keywordsGroup.'\)\(\s\|(\)'
    let currentLine = getline('.')
    if match(currentLine, only) >= 0
        s/\.only//g
    elseif match(currentLine, noOnly) >= 0
        normal! 0ea.only
    endif
endfunction

nnoremap <leader>o :call Mocha_Toggle_Only()<cr>

vnoremap <leader>64 c<c-r>=system('base64', @")<cr><esc>dd

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `\s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" SnipMate
imap <expr> <C-J> pumvisible() ? '<esc>a<Plug>snipMateNextOrTrigger' : '<Plug>snipMateNextOrTrigger'

let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-mocha'

nnoremap <leader>co :copen<cr>

" Purescript
let g:psc_ide_syntastic_mode = 1
let g:purescript_indent_if = 2
let g:purescript_indent_case = 2
let g:purescript_indent_let = 2
let g:purescript_indent_where = 2
let g:purescript_indent_do = 2
let g:purescript_indent_in = 2

imap jk <Esc>

execute 'source ' . config_haskell

