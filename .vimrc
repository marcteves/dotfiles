
if v:progname =~? "evim"
  finish
endif

set nocompatible

set backspace=indent,eol,start

" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file (restore to previous version)
"   set undofile		" keep an undo file (undo changes after closing)
" endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hidden		" allow sending buffer to background without writing

map Q gq
map <F2> :GFiles<CR>
map <F3> :ls<CR>
map <F4> :b 
map <F5> :checktime<CR>
map <F6> :Files<CR>
map <F11> :source ~/.vimrc<CR>

" press ctrl-U to delete line in insert mode
inoremap <C-U> <C-G>u<C-U>


if has('mouse')
  set mouse=a
endif

" if &t_Co > 2 || has("gui_running")
"   syntax on
"   set hlsearch
" endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

if !has('nvim')
	packadd matchit
endif

set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildmenu
set splitright
set nocursorline

command! MakeTags !ctags -R .

let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize=75

let g:ale_lint_on_text_changed='always'
let g:ale_delay=2000
" let g:ale_linters = {'elixir': ['mix']}
" let g:ale_linters_ignore = {'elixir': ['dialyxir', 'elixir-ls']}
let g:ale_linters_ignore = {'elixir': ['dialyxir']}
let g:ale_elixir_elixir_ls_release = '/home/reimu/.mix/elixir-ls/release'
let g:ale_elixir_elixir_ls_config = {'elixirLS': { 'dialyzerEnabled': v:false}}

set makeprg=make

" Add line numbers to the first column
set number
set relativenumber

" Highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=grey guibg=grey 

set scrolloff=5 " keep 5 lines above and below
set autoread	" restart buffer if a change outside of vim is detected
set exrc 	" Read the project directory .vimrc if it exists
set noswapfile	" Too pro for this?
set nohlsearch
set fileencodings=utf-8,shift-jis,sjis,iso-2022-jp,euc-jp,ucs-bom,cp932,default "Weeb shit
set tabstop=4
set shiftwidth=4
let g:sql_type_default = 'mysql'

call plug#begin('~/.vim/plugged')

" surround text
Plug 'tpope/vim-surround'

" fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" local vim configs
Plug 'editorconfig/editorconfig-vim'

" lint as you type
Plug 'w0rp/ale'

" elixir...
Plug 'elixir-editors/vim-elixir'

" highligh trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" latex plugin
Plug 'lervag/vimtex'

" ripgrep in quickfix
Plug 'jremmen/vim-ripgrep'

" vue syntax highlight
Plug 'storyn26383/vim-vue'

call plug#end()
