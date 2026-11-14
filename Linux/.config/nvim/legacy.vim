" Use syntax highlighting
syntax on

" Show line numbers
set relativenumber
set number

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4

" Enable mouse support
set mouse=a

" Enable backup files
set backup
set backupdir=~/.vim/backup
set backupdir+=.

" Enable swap files
set swapfile
set directory=~/.vim/swap

" Search related changes
set hlsearch
set incsearch
set ignorecase
set smartcase

" Enable autoindentation
set autoindent
set smartindent

" Set scroll offset
set scrolloff=5
set sidescrolloff=10

" Enable 256-color support
set t_Co=256

" Set font to Consolas 10pt
if has("gui_running")
    if exists("g:neovide")
      " Neovide specific code
    endif
    if has("gui_gtk3")
      set guifont=monospace\ 9
    endif
    if has("gui_win32")
      set guifont=Consolas:h10
    endif
    
  set lines=50 columns=95
endif

" Hide menu bar
set guioptions-=m
" Hide toolbar
set guioptions-=T
" Hide scrollbar
set guioptions-=r

" Show ruler
set laststatus=2
set nowrap
