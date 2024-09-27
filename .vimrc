set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'SuperTab'
Plugin 'file-line'
Plugin 'The-NERD-tree'
Plugin 'lifepillar/vim-solarized8'
Plugin 'venantius/vim-cljfmt'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'plasticboy/vim-markdown'
Plugin 'tComment'
Plugin 'rhysd/vim-crystal'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Lazy-load some plugins
call vundle#end()

" General settings
filetype plugin indent on
colorscheme solarized8

syntax enable
set background=dark
set relativenumber
set number
set autoindent
set wildmenu
set wildignore+=*/tmp/*,.git,.svn,CVS,*.o,*.a,*.class,*.obj,*.so,*~,*.swp,*.zip,*.log,*.log.*,*.jpg,*.png,*.xpm,*.gif,*.pdf

" Optimize searches
set ignorecase
set smartcase
nnoremap * /\C\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\C\<<C-R>=expand('<cword>')<CR>\><CR>

" Backup and undo settings
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Enable mouse
set mouse=r

" NERDTree mappings
map <Tab> :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>

" Custom statusline
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/home/bargo/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" Highlight trailing whitespace
highlight EOLWS ctermbg=red guibg=red
autocmd InsertEnter * syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn match EOLWS excludenl /\s\+$/

" Folding for markdown
let g:vim_markdown_folding_disabled=1

" Enable ESLint with syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" Visual Search function
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    execute "Rgrep -i " . l:pattern
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Key mappings for Visual Search
vnoremap <silent> * :call VisualSearch('b')<CR>
vnoremap <silent> # :call VisualSearch('f')<CR>
vnoremap <silent> gv :call VisualSearch('gv') <Bar> cw<CR>

" Jump to the last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Other key mappings
map Q gq
inoremap <C-U> <C-G>u<C-U>
noremap j gj
noremap k gk
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Filetype specific settings
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufRead *.ejs set filetype=html
au FileType python set tabstop=4 shiftwidth=4 textwidth=140 softtabstop=4

" Enable Ruby pair colors
let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ]

" More syntax highlighting improvements
syntax enable
set t_Co=256

