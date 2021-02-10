"Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,ucs-bom,seuc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set wildmenu
"set wildmode=list:longest
set autoread
set hidden

"Indent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set smarttab
set expandtab

"Search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><ESC>

set complete=.,w,b,u,U,s,i,d,t
set completeopt& completeopt+=menuone completeopt+=noinsert completeopt-=preview
"for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
"endfor

"set laststatus
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

augroup DeleteSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup ReloadVimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

set clipboard=unnamedplus clipboard+=unnamed

set noswapfile
set number
set belloff=all

"fold by indent
set foldmethod=indent
set foldlevel=7

syntax on
let g:mapleader = "\<Space>"
inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <C-w>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>j

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

inoremap <expr><Tab>   pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<Up>" : "\<S-Tab>"

nnoremap ,.  :<C-u>edit $MYVIMRC<CR>
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

cnoremap <C-p> <Up>
noremap x "_x

function! s:fetch_absolute_path()
  let @* = expand('%:p')
endfunction
function! s:copy_absolute_path()
  call s:fetch_absolute_path()
  echo 'Copy absolute path: ' . @*
endfunction
function! s:copy_relative_path_from_root()
  call s:fetch_absolute_path()
  let @* = substitute(@*, '/home/mrbigass/works/', '', 'g')
  echo 'Copy relative path: ' . @*
endfunction

augroup MyAutoCmd
  autocmd WinEnter <buffer> checktime
augroup END

nmap cp :call <SID>copy_absolute_path()<CR>
nmap cpr :call <SID>copy_relative_path_from_root()<CR>

"PluginManager
call plug#begin('~/.vim/plugged')

"document
Plug 'vim-jp/vimdoc-ja'

"completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dense-analysis/ale'

"style
Plug 'doums/darcula'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'mrbigass/vim-prettier', { 'do': 'yarn install'  }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'

"operation
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/vim-auto-save'
Plug 'scrooloose/nerdtree'

"FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

"browser
Plug 'tyru/open-browser.vim'

"git
Plug 'iberianpig/tig-explorer.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"rails
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'

"vue
Plug 'posva/vim-vue'


call plug#end()

filetype plugin indent on

syntax enable
colorscheme darcula

"plugin config================================
"vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"indentline"
"let g:indentLine_color_term =239
"let g:indentLine_color_gui = '#708090'
"let g:indentLine_char = '¦'

"ale
" 保存時のみ実行
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"NERDTree
let g:NERDTreeShowHidden=1
nnoremap <silent><Leader>t :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$', '\.DS_Store']

"FZF
nnoremap ff :GFiles<CR>
nnoremap fs :GFiles?<CR>
nnoremap fb :Buffers<CR>
nnoremap fl :Lines<CR>
nnoremap fr :Rg<CR>

"asyncomplete
"inoremap <expr><CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

"fugitive
nnoremap gd :Gvdiffsplit<CR>

"tig-explorer
nnoremap gt :TigOpenProjectRootDir<CR>

"close-tag
let g:closetag_filenames = '*.html,*.vue'

"vim-prettier
let g:prettier#autoformat_config_present = 1 "prettireの設定ファイルがあった場合、そちらを優先する

" カーソル下のURLをブラウザで開く
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>"

"nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
