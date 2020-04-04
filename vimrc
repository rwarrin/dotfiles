
" execute pathogen
execute pathogen#infect()

let HOME=$VIM       " set home directory
set nocompatible    " disable vi compatibility
syntax enable       " enable syntax highlighting
set number          " show line numbers
set autoindent      " automatically indent lines
set smartindent     " smart indenting works like autoindent but recognizes some
                    " C syntax to increase/decreased indent (overrides
                    " autoindent)
set cindent         " works more cleverly than the previous two indents
"set autoread        " automatically reload files when changed on disk
set backupcopy=yes  " create a backup of files
set backupdir=$VIM/vimfiles/backup//    " directory to store backups
"set backupdir=$VIM\vimfiles\backup\\   " windows
set clipboard=unnamed	" use system clipboard
set directory-=$VIM/vimfiles/swap//    " don't store swap files in the current directory
"set directory-=$VIM\vimfiles\swap\\   " windows
set ignorecase      " case insensitive searching
set smartcase       " use case sensitive search if there are any caps
set incsearch       " search as you type
set hlsearch        " highlight search
set laststatus=2    " always show statusline
"set list            " show whitespace
"set listchars=tab:›\ ,trail:•
"set listchars=tab:›\ ,trail:·
set ruler           " show cursor position in file
set scrolloff=3     " minimum number of lines to keep above/below cursor
set tabstop=4       " use a mix of tabs and spaces for to align to the closest
set softtabstop=4   " tabstop, using backspace will behave like a tab appears
set shiftwidth=4    " how much to indent when shifting with >> and <<
set shiftround	    " round to the nearest tabstop
set expandtab       " convert tabs to spaces
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
set textwidth=80	" 80 columns used to place color column
set formatoptions-=t	" disable automatic text wrapping at text width setting
set cursorline		" highlight current line
set backspace=2		" backspace everything in insert mode
filetype plugin on
filetype plugin indent on

" better autocomplete
set complete=.,w,b,u,t,i
set completeopt=menu,menuone,preview,noinsert

if v:version >= 703
	set undodir=$VIM/swap
"set undodir=$VIM\\vimfiles\undo\\
	set undofile

	set colorcolumn=+1
endif

" base16 color scheme settings
let base16colorspace=256
colorscheme base16-default-dark

" keyboard shortcuts
let mapleader=','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>s :sort<CR>
map <silent> <leader>V :source D:/Development/Vim/_vimrc<CR>:filetype detect<CR>:exe ":echo '_vimrc reloaded'"<CR>
nmap <leader>gt :GitGutterToggle<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap <leader>e :call ToggleQuickFixHeight()<CR>
nnoremap <leader>E :let g:custom_quick_fix_height = 40<CR>:cclose<CR>
nnoremap <leader>l :lopen<CR>
nnoremap <leader>L :lclose<CR>
nmap <S-j> 10j<CR>
nmap <S-k> 10k<CR>
map <leader>b :make!<CR><CR>
nnoremap <M-left> :bp<CR>
nnoremap <M-right> :bn<CR>
nnoremap <S-F8> :TagbarToggle<CR>
nnoremap <leader>h :call HeaderToggle()<CR>

" plugin settings
let NERDTreeShowHidden=1    " show hidden files in NERDTree

" enable spell check when writing commit messages
autocmd filetype git,*commit* setlocal spell
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" use ripgrep for greping - use the full path to rg.exe if it is not in the path
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m

" status line
set statusline=%*
set statusline+=[%N]	" buffer number
set statusline+=%#error#%m%*	" modified flag [+] or [-]
set statusline+=%r		" readonly flag
set statusline+=%w		" preview flag
set statusline+=\ %f	" file name
set statusline+=%1*%y%*		" file type

set statusline+=%=		" seperate left/right align

set statusline+=[%{&fo}]\ 	" show format options
set statusline+=c%c\ 	" column number
set statusline+=\ %l,%L	" current line number, number of lines
set statusline+=\ %P		" percentage through file

" Custom keyword highlighting
augroup customHighlights
    au!
    au Syntax * syntax keyword customHighlightImportant IMPORTANT contained Ni
    au Syntax * syntax keyword customHighlightNote NOTE contained Ni
    au Syntax * syntax keyword customHighlightTodo TODO contained Ni
    au Syntax * syntax cluster cCommentGroup add=customHighlightImportant
    au Syntax * syntax cluster cCommentGroup add=customHighlightNote
    au Syntax * syntax cluster cCommentGroup add=customHighlightTodo
    au Syntax * highlight customHighlightImportant term=bold,underline cterm=bold,underline ctermfg=1 gui=bold,underline guifg=#ab4642
    au Syntax * highlight customHighlightNote term=bold cterm=bold ctermfg=2 gui=bold guifg=#a1b56c
    au Syntax * highlight customHighlightTodo term=bold cterm=bold ctermfg=3 gui=bold guifg=#f7ca88
augroup END

" Quickswitch between header and source file
function! HeaderToggle() " bang for overwrite when saving vimrc
    let file_path = expand("%")
    let file_name = expand("%<")
    let extension = split(file_path, '\.')[-1] " '\.' is how you really split on dot

    if extension == "cpp" || extension == "c"
        let next_file = join([file_name, ".h"], "")
        if filereadable(next_file)
            :e %<.h
        else
            " Default to creating a .h header file if it doesn't already exist
            :e %<.h
        endif
    elseif extension == "h"
        let c_next_file = join([file_name, ".c"], "")
        let cpp_next_file = join([file_name, ".cpp"], "")
        if filereadable(c_next_file)
            :e %<.c
        elseif filereadable(cpp_next_file)
            :e %<.cpp
        else
            " Default to creating a .cpp source file if it doesn't already exist
            :e %<.cpp
        endif
    endif
endfunction

" Swap two open buffers
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction
nmap <silent> <leader>mb :call MarkWindowSwap()<CR>
nmap <silent> <leader>sb :call DoWindowSwap()<CR>

" Bindings for functions exported by gvimwindowstyles.dll
nnoremap <leader>F :call libcallnr("gvimwindowstyles.dll", "ToggleFullscreen", 0)<CR>
command! Sticky :call libcallnr("gvimwindowstyles.dll", "ToggleStickyWindow", 0)
command! -nargs=1 Opacity :call libcallnr("gvimwindowstyles.dll", "SetOpacity", <args>)

" Toggle the size of the quick fix window
let g:custom_quick_fix_height = 40
function! ToggleQuickFixHeight()
    if g:custom_quick_fix_height == 10
        let g:custom_quick_fix_height = 40
    else
        let g:custom_quick_fix_height = 10
    endif

    execute "copen" g:custom_quick_fix_height
endfunction
