set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
"Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
"Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'benekastah/neomake'
Plugin 'shime/vim-livedown'
Plugin 'wavded/vim-stylus'
"Plugin 'lambdatoast/elm.vim'
Plugin 'szw/vim-ctrlspace'
"Plugin 'scrooloose/syntastic'
"Plugin 'leafgarland/typescript-vim'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'Quramy/tsuquyomi'
Plugin 'mbbill/undotree'
Plugin 'vim-ruby/vim-ruby'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'

call vundle#end()
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

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

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set smarttab
set expandtab
set smartindent
set ruler
set ttyfast
set autoread
set more
set cursorline!
set number

set listchars=nbsp:¬,tab:»·,trail:·
set list

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
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
"set wildignore+=*node_modules*
set hidden
set switchbuf=useopen

nnoremap <Leader>r :.,$s/\<<C-r><C-w>\>/
nnoremap <Leader>s :/\<<C-r><C-w>\><cr>

nnoremap <Leader>o :CtrlPBuffer<cr>
nnoremap <C-E> :NERDTreeToggle<CR>
nnoremap ,n :NERDTreeFind<cr>

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
augroup END

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>es :e ~/.ssh/config<cr>

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
    for bundle in g:vundle#bundles
        if bundle.name == "vim-ctrlspace"
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

"nnoremap <leader>cc :call NERDComment(0, "invert")<cr>
"vnoremap <leader>cc :call NERDComment(0, "invert")<cr>

set backspace=indent,eol,start
set relativenumber

" Removes trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <leader>rts :call TrimWhiteSpace()<cr>

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

let &colorcolumn=join(range(121,999),",")
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

"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_loc_list_height = 5
"let g:syntastic_coffee_coffeelint_args = "--file /Users/trucker/code/actano/rplan/coffeelint.json"
"let g:syntastic_coffee_checkers = ['coffeelint']
"let g:syntastic_always_populate_loc_list = 1

" typescript-vim
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow

" neomake
let g:neomake_coffeescript_enabled_makers = ['coffeelint']
autocmd! BufWritePost * Neomake

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
