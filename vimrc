
" execute pathogen
execute pathogen#infect()

set nocompatible    " disable vi compatibility
syntax enable       " enable syntax highlighting
set number          " show line numbers
set autoindent      " automatically indent lines
set smartindent     " smart indenting works like autoindent but recognizes some
                    " C syntax to increase/decreased indent (overrides
                    " autoindent)
set cindent         " works more cleverly than the previous two indents
set autoread        " automatically reload files when changed on disk
set backupcopy=yes  " create a backup of files
set clipboard=unnamed   " use system clipboard
set directory-=.    " don't store swap files in the current directory
set ignorecase      " case insensitive searching
set smartcase       " use case sensitive search if there are any caps
set incsearch       " search as you type
set hlsearch        " highlight search
set laststatus=2    " always show statusline
set list            " show whitespace
set listchars=tab:↦\ ,trail:⋅
set ruler           " show cursor position in file
set scrolloff=3     " minimum number of lines to keep above/below cursor
set tabstop=4       " use a mix of tabs and spaces for to align to the closest
set softtabstop=4   " tabstop, using backspace will behave like a tab appears
set shiftwidth=4    "
set shiftround		" round to the nearest tabstop
set noexpandtab     "
set showcmd         " show partial command in the last line of the screen
set wildmenu        " command-line completion
set wildmode=longest,list,full
set nowrap          " don't wrap lines
set shortmess+=I    " skip splash screen
set background=dark " use colors for dark backgrounds
set splitbelow      " horizontal splits open below
set splitright      " vertical splits open right
set complete=.,t    " use current file and ctags for completion
set history=1000	" number of commands to keep in history
set sidescroll=1	" minimal number of columns to scroll horizontally
set sidescrolloff=7	" minimal number of columns to keep left/right of cursor
					" when scrolling horizontal
set foldmethod=indent	" fold using indents
set foldnestmax=3	" deepest fold level
set nofoldenable	" don't fold by default
set t_Co=256		" terminal has 256 colors
set spelllang=en_us	" use US english dictionary for spell checking
set cino+=(0		" align wrapped function arguments

if v:version >= 703
	set undodir=~/.vim/undofiles
	set undofile

	set colorcolumn=+1
endif

" base16 color scheme settings
let base16colorspace=256
colorscheme base16-default

" keyboard shortcuts
let mapleader=','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>s :sort<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo '~/.vimrc reloaded'"<CR>
nmap <leader>gt :GitGutterToggle<CR>

" plugin settings
let NERDTreeShowHidden=1    " show hidden files in NERDTree

" enable spell check when writing commit messages
autocmd filetype git,*commit* setlocal spell
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" status line
set statusline=%*
set statusline+=[%N]	" buffer number
set statusline+=%#error#%m%*	" modified flag [+] or [-]
set statusline+=%r		" readonly flag
set statusline+=%w		" preview flag
set statusline+=\ %f	" file name
set statusline+=%1*%y%*		" file type

set statusline+=%=		" seperate left/right align

set statusline+=c%c\ 	" column number
set statusline+=\ %l,%L	" current line number, number of lines
set statusline+=\ %P		" percentage through file

hi User1 term=bold cterm=bold ctermfg=blue ctermbg=19

