" Configuration File
" Description: My vimrc config file, for C++, Rust, Python dev etc.
" Author: Roman Maslennikov
" Based on: 'Minimal .vimrc for C/C++ developers'
"
set shell=/bin/bash
let mapleader = "\<Space>"

set nocompatible              " be iMproved, required
filetype off                  " required
set noswapfile                "Disable swapping fiels

call plug#begin()
" Color scheme
Plug 'tomasiser/vim-code-dark'

" Git Magit
Plug 'jreybert/vimagit'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
" Nerd tree
Plug 'preservim/nerdtree'

" Fuzzy finder
" Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ziglang/zig.vim'
Plug 'neovimhaskell/haskell-vim'
" Plug 'plasticboy/vim-markdown'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Multiple selection
" Plug 'terryma/vim-multiple-cursors'

" Visualize marks
Plug 'kshenoy/vim-signature'

" Git branch plugin
Plug 'itchyny/vim-gitbranch'

" Easy motion plugin
" Plug 'easymotion/vim-easymotion'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Grammar checking
Plug 'rhysd/vim-grammarous'

" Minimap
" Plug 'https://github.com/severin-lemaignan/vim-minimap.git'

""Surround is all about surroundings, commands cs"', ds etc.
"Plugin 'tpope/vim-surround'
"" Famous unimpared plugin
"Plugin 'tpope/vim-unimpaired'
"" Python autoindent plugin
"Plugin 'vim-scripts/indentpython.vim'
""Color theme
"Plugin 'tomasr/molokai'
"" Javascript bundle
"Plugin 'pangloss/vim-javascript'

call plug#end()

" Get syntax
syntax on

filetype plugin indent on

" PUT YOUR NON-PLUGIN STUFF AFTER THIS LINE
"
" -----------------------------------------------------------------------------------------
"                           COMPLETION SETTINGS
" -----------------------------------------------------------------------------------------
" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
" let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Alt variant
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" 'Smart' navigation
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" nmap <silent> F <Plug>(ale_lint)
" nmap <silent> <C-l> <Plug>(ale_detail)
" nmap <silent> <C-g> :close<cr>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Applying CocAction command
nmap <leader>a :<C-u>CocAction<cr>
" Analog?
"nnoremap <silent> <space>a  :CocAction<cr>

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Find symbol of current document.
nnoremap <silent> gss  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> gw :<C-u>CocList -I symbols<cr>

" Use <TAB> for selections ranges.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" -----------------------------------------------------------------------------------------
"                           COMMON SETTINGS
" -----------------------------------------------------------------------------------------

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" -----------------------------------------------------------------------------------------
"                           EDITOR SETTINGS
" -----------------------------------------------------------------------------------------
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
"
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

" enable Normal mode keys in ru layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

"
" Visualize marksAlways draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent

"syntax folding
set foldmethod=syntax

" disable folding
set nofoldenable

"configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set softtabstop=4    " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
" turn line numbers on
set relativenumber 
set number 
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Switch buf behaviour
set switchbuf=useopen,usetab

" Clipboard integration
set clipboard^=unnamed,unnamedplus

" Auto save on buffer change
set autowriteall

" =============================================================================
" # GUI settings
" =============================================================================
" Set gui font
"set guifont=PragmataPro\ Mono:h12

set ruler " Where am I?
" Turn of annoying spelling check 
set nospell
" Solve bakcspace problem
set backspace=2 
" Incremetn searhc?
set incsearch
" Set short message
set shortmess=at
" Middle-click paste with mouse
set mouse=a
" Highlight cursorline
set cursorline
set cursorcolumn

set colorcolumn=120 " and give me a colored column
set showcmd " Show (partial) command in status line.

set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2

" Visible whitespaces
set listchars=tab:>@,trail:~,extends:>,precedes:<,space:·,
set list

" == LIGHTLINE SETTINGS ==
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'modified' ], ['filename', 'gitbranch'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], ['fileformat', 'fileencoding', 'filetype',] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


" =============================================================================
"                       HOTKEYS
" =============================================================================
"
" List of unused: https://vim.fandom.com/wiki/Unused_keys
"
"test  mapping
" inoremap <leader>d <C-R>=strftime("%Y-%m-%dT%H:%M")<CR>

" Open hotkeys
noremap <C-p> :Files<CR>
nnoremap <leader>; :Buffers<CR>

" Quick-save
nnoremap <leader>w :w<CR>
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, toogle, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" "" in normal mode F2 will save the file
" "nmap <F2> :w<CR>
" "" in insert mode F2 will exit insert, save, enters insert again
" ""imap <F2> <ESC>:w<CR>i
" "imap <F2> <ESC>:w<CR>
" "" switch between header/source with F4
" "map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" "" build using makeprg with <F5>
" "map <F5> :make<CR><CR>
" "" run python script
" "map <S-F5> <F2>:!C:/Python27/python %<CR><CR>
" "" create doxygen comment
" "map <F6> :Dox<CR><CR>
" "" recreate tags file with F7
" "map <F7> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR><CR>
" "" build using makeprg with <S-F7>
" "map <S-F7> :make clean all<CR><CR>
" "" goto definition with F12
" "map <F12> <C-]>
" "" fullscreen toggle
" "map <C-CR> :WToggleFullscreen<CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f NOTE: useless to me
" inoremap <C-f> :sus<cr>
" vnoremap <C-f> :sus<cr>
" nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
" map H ^
" map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg 
let g:fzf_layout = { 'down': '~40%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" function! s:list_cmd()
"   let base = fnamemodify(expand('%'), ':h:.:S')
"   return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
" endfunction

" Not working
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
"   \                               'options': '--tiebreak=index'}, <bang>0)


" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Terminal hotkeys
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w> <C-\><C-n>

" Move by line
nnoremap j gj
nnoremap k gk

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_
noremap <leader>n ct-

" Tab switching
nnoremap <F1> 1gt
nnoremap <F2> 2gt
nnoremap <F3> 3gt
nnoremap <F4> 4gt
nnoremap <F5> 5gt
nnoremap <F6> 6gt
nnoremap <F7> 7gt

" ===== EASY MOTION HOTKEYS =====
"
let g:EasyMotion_do_mapping = 0
" <Leader>f{char} to move to {char}
map  <A-f> <Plug>(easymotion-bd-f)
nmap <A-f> <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <A-s> <Plug>(easymotion-overwin-f2)

" Move to line
map  <A-l> <Plug>(easymotion-bd-jk)
nmap <A-l> <Plug>(easymotion-overwin-line)

" Move to word
map  <A-w> <Plug>(easymotion-bd-w)
nmap <A-w> <Plug>(easymotion-overwin-w)

" Close all buffers but this one
map <leader>o :%bd!\|e#<cr>

" ===== SIGNATURE HOTKEYS =====
"
nnoremap <leader>j :<C-U>call signature#mark#Goto("next", "spot", "global")<CR>
nnoremap <leader>k :<C-U>call signature#mark#Goto("prev", "spot", "global")<CR>
nnoremap <A-j> ]'
nnoremap <A-k> ['
vnoremap <A-j> ]'
vnoremap <A-k> ['
nmap <leader>t m.
nmap <c-space> m.

" ------------------------------------------------------------------------------
"                         COLOR SCHEMES
" ------------------------------------------------------------------------------
" Activate color scheme
" colorscheme molokai
"colorscheme wombat256

" Color scheme
"set background=dark
"let g:molokai_original = 1
""let g:rehash256 = 1
"colorjcheme molokai

set t_Co=256
set t_ut=
let g:codedark_conservative = 1
colorscheme codedark
let g:airline_theme = 'codedark'

"Tagbar binding
nmap <F8> :TagbarToggle<CR>


"  rust_analyzer LSP setup
" call nvim_lsp#setup("rust_analyzer", {})


"Setting for airline status bar
"let g:airline#extensions#tabline#enabled = 1

" Reverse letters in selection
vnoremap <silent> <Leader>is :<C-U>let old_reg_a=@a<CR>
 \:let old_reg=@"<CR>
 \gv"ay
 \:let @a=substitute(@a, '.\(.*\)\@=',
 \ '\=@a[strlen(submatch(1))]', 'g')<CR>
 \gvc<C-R>a<Esc>
 \:let @a=old_reg_a<CR>
 \:let @"=old_reg<CR>

" Search for visually selected text
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" AUTOSAVE SETTINGS
" Save on focus lost
" :au FocusLost * silent! wa
" :set autowrite

" NERDTree SETTINGS
let NERDTreeShowHidden=1
let NERDTreeWinSize=60
let g:NERDTreeMouseMode=3
" How can I open a NERDTree automatically when vim starts up if no files were specified?
" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

hi Normal guibg=NONE ctermbg=NONE

" INSERT CURRENT DATE
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>

