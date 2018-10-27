" ~/.config/nvim/int.vim

"install vim-plug and plugins if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugins')
Plug 'christoomey/vim-sort-motion'
Plug 'joshdick/onedark.vim' "colorscheme
Plug 'ncm2/ncm2' "formerly nvim-completion-manager - unneeded given w0rp/ale?
Plug 'ncm2/ncm2-bufword' "complete words from current buffer
Plug 'ncm2/ncm2-tmux' "complete words from other tmux panes
Plug 'roxma/nvim-yarp' "required for ncm2
Plug 'sheerun/vim-polyglot'
Plug 'srstevenson/vim-picker'
Plug 'srstevenson/vim-topiary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession' "manage sessions
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline' "status line
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

"""""""""""""
"vim settings
let mapleader = ';'
filetype plugin indent on
syntax on
colorscheme onedark
set encoding=utf-8
set textwidth=80
"show where 'textwidth' ends
set colorcolumn=+1
"show line numbers
set number
"show what's pressed in command mode
set showcmd
"expand tabs/shift as 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
"round indent to multiple of 'shiftwidth'
set shiftround
"open new split panes below instead of above, and to right not left
set splitbelow
set splitright

"navigate betwen windows quicker
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"open and edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"source vimrc to apply it in current session
nnoremap <leader>sv :source $MYVIMRC<cr>

"insert blank line below without leaving normal mode
nnoremap <C-o> o<Esc>k

"make me into a good vim user...
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>

"have shift+3 be # (previous ^+3 was £, alt+3 was #)
inoremap £ #
"type backticks with crtl+z
inoremap  `

"enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
"suggested way to manage ncm2 popups, see :help Ncm2PopupOpen
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone
"use <TAB> to select the ncm2 popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:ale_completion_enabled = 1
let g:ale_open_list = 1
"see ale status in nicer format
let g:airline#extensions#ale#enabled = 1

""auto replace triple dots with ellipsis symbol
augroup markdown
  autocmd FileType markdown iabbrev <buffer> ... …
augroup END

"close documentation preview window after autocomplete
augroup preview
    autocmd!
    autocmd CompleteDone * pclose
augroup END

"airline status/tabline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1

"highlight YAML frontmatter in jekyll
let g:vim_markdown_frontmatter = 1

""""""""""""
"file picker
"use ripgrep for file picker (when not in a git repo)
let g:picker_find_executable = 'rg'
let g:picker_find_flags = '--color never --files'

"picker key sequences Scott recommends
nmap <leader>pe <Plug>PickerEdit
nmap <leader>ps <Plug>PickerSplit
nmap <leader>pt <Plug>PickerTabedit
nmap <leader>pv <Plug>PickerVsplit
nmap <leader>pb <Plug>PickerBuffer
nmap <leader>p] <Plug>PickerTag
nmap <leader>pw <Plug>PickerStag
nmap <leader>po <Plug>PickerBufferTag
nmap <leader>ph <Plug>PickerHelp

""""""
"julia
"point to executable (even though julia already on PATH in /usr/local/bin)
let g:ale_julia_executable =
\   '/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia'

"julia-vim settings - not sure if needed with vim-polyglot
let g:default_julia_version = '1.0'
"automatically substitute unicode for latex in julia
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_eager = 1
let g:latex_to_unicode_suggestions = 1
let g:latex_to_unicode_tab = 1

"get julia-vim to play nicely with delimitmate
" autocmd FileType julia let b:delimitMate_expand_space=0

"use language server for julia completion
"see https://github.com/JuliaEditorSupport/LanguageServer.jl/wiki/Vim-and-Neovim
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['/Applications/Julia-1.06.app/Contents/Resources/julia/bin/julia',
\   '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
\       server.runlinter = true;
\       run(server);
\   '],
\ }
nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<cr>
