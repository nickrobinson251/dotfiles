" ~/.config/nvim/int.vim
"
"instal vim-plug and plugins if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugins')
" Plug 'AndrewRadev/splitjoin.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', {
\       'branch': 'next',
\       'do': 'bash install.sh'}
Plug 'christoomey/vim-sort-motion'
Plug 'joshdick/onedark.vim' "colorscheme
Plug 'ncm2/ncm2' "formerly nvim-completion-manager
Plug 'ncm2/ncm2-bufword' "complete words from current buffer
Plug 'ncm2/ncm2-tmux' "complete words from other tmux panes
Plug 'roxma/nvim-yarp' "required for ncm2
Plug 'srstevenson/vim-picker'
Plug 'srstevenson/vim-topiary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline' "status line
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' "not sure we need this if using LanguageServer
call plug#end()

"""""""""""""
"vim settings
filetype plugin indent on
syntax on
colorscheme onedark

"Show line numbers
set nu
set textwidth=80
"Show what's pressed in command mode
set showcmd
"Expand tabs as 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4

let mapleader = ';'

"enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

"suggested way to manage ncm2 popups, see :help Ncm2PopupOpen
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone

"open and edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"source vimrc to apply it in current session
nnoremap <leader>sv :source $MYVIMRC<cr>

"insert blank line below without leaving normal mode
nnoremap <C-o> o<Esc>k

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
let g:airline_theme = 'term'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"highlight YAML frontmatter in jekyll
let g:vim_markdown_frontmatter = 1

""""""""""""
"file picker
"
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
let g:ale_julia_executable = '/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia'

"julia-vim settings
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
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
