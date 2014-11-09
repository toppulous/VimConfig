if version >= 704
  execute pathogen#infect()
  let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
  let g:EclimCompletionMethod='omnifunc'
endif
  set encoding=utf-8
" Configuration file for vim
  set number
" Standard vim options
  set autoindent            " always set autoindenting on
  set backspace=2           " allow backspacing over everything in insert mode
  set cindent               " c code indenting
  set diffopt=filler,iwhite " keep files synced and ignore whitespace
  set expandtab             " Get rid of tabs altogether and replace with spaces
  set foldcolumn=2          " set a column incase we need it
  set foldlevel=0           " show contents of all folds
  set foldmethod=indent     " use indent unless overridden
  set guioptions-=m         " Remove menu from the gui
  set guioptions-=T         " Remove toolbar
  set hidden                " hide buffers instead of closing
  set history=50            " keep 50 lines of command line history
  set ignorecase            " Do case insensitive matching
  set incsearch             " Incremental search
  set laststatus=2          " always have status bar
  set linebreak             " This displays long lines as wrapped at word boundries
  set matchtime=10          " Time to flash the brack with showmatch
  set nobackup              " Don't keep a backup file
  set nocompatible          " Use Vim defaults (much better!)
  set nofen                 " disable folds
  set notimeout             " i like to be pokey
  set ttimeout              " timeout on key-codes
  set ttimeoutlen=100       " timeout on key-codes after 100ms
  set ruler                 " the ruler on the bottom is useful
  set scrolloff=1           " dont let the curser get too close to the edge
  set shiftwidth=4          " Set indention level to be the same as softtabstop
  set showcmd               " Show (partial) command in status line.
  set showmatch             " Show matching brackets.
  set softtabstop=4         " Why are tabs so big?  This fixes it
  set textwidth=0           " Don't wrap words by default
  set textwidth=80          " This wraps a line with a break when you reach 80 chars
  set virtualedit=block     " let blocks be in virutal edit mode
  set wildmenu              " This is used with wildmode(full) to cycle options

"Longer Set options
  set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-   " useful for cscope in quickfix
  set listchars=tab:>-,trail:-                 " prefix tabs with a > and trails with -
  set tags+=./.tags;/,./tags;/                 " set ctags
  set whichwrap+=<,>,[,],h,l,~                 " arrow keys can wrap in normal and insert modes
  set wildmode=list:longest,full               " list all options, match to the longest

" set helpfile=$VIMRUNTIME/doc/help.txt
  set guifont=Courier\ 10\ Pitch\ 10
  set path+=.,..,../..,../../..,../../../..,/usr/include
  
  " Suffixes that get lower priority when doing tab completion for filenames.
  " These are files I am not likely to want to edit or read.
  set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class
  
"Set colorscheme.  This is a black background colorscheme
  colorscheme desert

" viminfo options
  " read/write a .viminfo file, don't store more than
  " 50 lines of registers
  set viminfo='20,\"50    

  "vimspell variables
    "don't automatically spell check!
    let spell_auto_type=""    

  "taglist.vim settings
  if exists("g:useNinjaTagList") && g:useNinjaTagList == 1
    set updatetime=1000 "interval to update list window

    let Tlist_Auto_Open=1 "Auto open the list window
    let Tlist_Compact_Format=1 
    let Tlist_Ctags_Cmd = g:ApolloRoot . '/bin/ctags' "Ctags binary to use
    let Tlist_Enable_Fold_Column=0 "Turn off the fold column for list window
    let Tlist_Exit_OnlyWindow=1 "Exit if list is only window
    let Tlist_File_Fold_Auto_Close=1
    let Tlist_Show_Menu=1 "Show tag menu in gvim
    let Tlist_Use_Right_Window = 1 "put list window on the rigth

    "maps to close, and open list window
    map <silent> <Leader>tc :TlistClose<CR>
    map <silent> <Leader>to :TlistOpen<CR>
  endif

"Turn on filetype plugins to automagically
  "Grab commands for particular filetypes.
  "Grabbed from $VIM/ftplugin
  filetype plugin on
  filetype indent on

"Turn on syntax highlighting
syntax on

"Functions
fu! CscopeAdd() " Add Cscope database named .cscope.out
    let dir = getcwd()
    let savedir = getcwd()
    wh (dir != '/')
        let scopefile = dir . '/' . ".cscope.out"
        if filereadable(scopefile)
            exe "cs add " scopefile
            exe "cd " savedir
            return dir
        en
        cd ..
        let dir = getcwd()
    endw
    exe "cd " savedir
endf

"Adding mail as a spell checked type, only if in 7.0 >
if (v:version >= 700)
  au FileType mail set spell
endif

"When editing a file, make screen display the name of the file you are editing
function! SetTitle()
  if $TERM =~ "^screen"
    let l:title = 'vi: ' . expand('%:t')        
    
    if (l:title != 'vi: __Tag_List__')
      let l:truncTitle = strpart(l:title, 0, 15)
      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'     
    endif
  endif
endfunction

" Run it every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()

"Automatically delete trailing whitespace on write for specified filetypes
  " grab the file list from the variable g:EnvImprovement_DeleteWsFiletypes
  " the variable should be of type list
function! DeleteTrailingWhitespace()
    let l:EnvImprovement_SaveCursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:EnvImprovement_SaveCursor)
endfunction

if exists("g:EnvImprovement_DeleteWsFiletypes") && !empty(g:EnvImprovement_DeleteWsFiletypes)
    let filetypeString = join(g:EnvImprovement_DeleteWsFiletypes, ',')
    execute 'autocmd FileType ' . filetypeString  . ' autocmd BufWritePre <buffer> :call DeleteTrailingWhitespace()'
endif

" My standard format settings
  set number
  set softtabstop=2
  set tabstop=2
  set shiftwidth=2
  set expandtab

" Makes cursor go down a single row on the screen (regardless of wrap around)
  nmap j gj 
  nmap k gk 

" Allows me to cycle between open buffers
  nmap <C-n> :bnext<CR>
  nmap <C-p> :bprev<CR>
  nmap <C-e> :e #<CR>

" toggles 
  nmap \l :setlocal number!<CR> 
  nmap \o :set paste!<CR>
  nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

"Support for heathen code formatting 
  nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
  nmap \t :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
  nmap \M :set noexpantab tabstop=8 softtabstop=4 shiftwidth=4<CR>
  nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" closetag.vim - automaticaly adds closing tag when </ typed
