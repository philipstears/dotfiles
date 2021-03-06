" UTF-8 is always a better bet (especially with things like NERDTree on remote
" shells)
set encoding=utf-8

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" SWP files don't belong where I'm editing goshdarnit
if has('unix')
  set dir=~/tmp
endif

" Philip: we always want a status line
set laststatus=2

" Philip: ensure that pathogen is loaded first
call pathogen#infect()
call pathogen#helptags()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
	" Philip - I don't want backup files hanging about littering
	" my workspace
	set nobackup
	set writebackup
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
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
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Philip's Settings:
set tw=0
set t_Co=256
set relativenumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Buffer redraws (helps with things like relative line numbers, and just
" generally on remote shells)
set lazyredraw

" Stop ctrl-p from re-indexing across new instances of vim
let g:ctrlp_clear_cache_on_exit = 0

" Change to the current working directory if possible, or on Windows, the user
" profile dir as a fallback
if !empty($pwd)
	cd $pwd
elseif !empty($home)
	cd $home
elseif !empty($userprofile)
	cd $userprofile
endif

set guioptions-=T " No toolbar
set guioptions-=t " No tear-off menus
colorscheme railscasts

 " automatically open and close the popup menu / preview window
 au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

 " Display-line based nav
nmap j gj
nmap k gk

 " Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

noremap <C-w><C-n> :vnew<cr>
noremap <C-n> :NERDTree<cr>

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Droid\ Sans\ Mono\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
"
" Show autocompletion alternatives for ex commands
set wildmenu

" Exclude certain file types from fuzzy matching
set wildignore+=*.o,*.d,*.bin,*.elf,*.sys,*.BIN,*.ELF,*.SYS,*.img,*.IMG,*.beam

" Down with trailing whitespace!
autocmd BufWritePre * :%s/\s\+$//e
