" ~/.config/nvim/int.vim

"install vim-plug and plugins if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-sort-motion'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'joshdick/onedark.vim' "colourscheme
Plug 'jpalardy/vim-slime' "send code to repl in different pane
Plug 'kdheepak/JuliaFormatter.vim'
Plug 'ncm2/ncm2' "formerly nvim-completion-manager - unneeded given w0rp/ale?
Plug 'ncm2/ncm2-bufword' "complete words from current buffer
Plug 'ncm2/ncm2-tmux' "complete words from other tmux panes
Plug 'roxma/nvim-yarp' "required for ncm2
Plug 'sheerun/vim-polyglot' "syntax for various languages - includes julia-vim
Plug 'tom--lee/julia-vim' "better indenting https://github.com/invenia/BlueStyle/issues/29
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
Plug 'w0rp/ale'
call plug#end()

"""""""""
"settings
let mapleader = ';'
syntax on
filetype plugin on
filetype indent on
set autoindent
" set lisp
set encoding=utf-8
set textwidth=88
set colorcolumn=+1 "show where 'textwidth' ends
set number "show line numbers
set showcmd "show what's pressed in command mode

"expand tabs/shift as 4 spaces
set expandtab
set shiftround "round indent to multiple of 'shiftwidth'
set shiftwidth=4
set softtabstop=4
set tabstop=4

"open new split panes below instead of above, and to right not left
set splitbelow
set splitright

"""""""""
nnoremap <C-J> a<CR><Esc>k$
"mappings
"navigate betwen windows quicker
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"open and edit vimrc in new tab
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
"source vimrc to apply it in current session
nnoremap <leader>sv :source $MYVIMRC<cr>

"open and edit gitconfig in new tab
nnoremap <leader>eg :tabnew ~/.dotfiles/tag-git/gitconfig<cr>

"insert blank line below without leaving normal mode
nnoremap <C-o> o<Esc>k

"shortcuts for vim-fugitive
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>

"make me into a good vim user...
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>

"picker key sequences Scott recommends
nmap <leader>pe <Plug>(PickerEdit)
nmap <leader>ps <Plug>(PickerSplit)
nmap <leader>pt <Plug>(PickerTabedit)
nmap <leader>pv <Plug>(PickerVsplit)
nmap <leader>pb <Plug>(PickerBuffer)
nmap <leader>p] <Plug>(PickerTag)
nmap <leader>pw <Plug>(PickerStag)
nmap <leader>po <Plug>(PickerBufferTag)
nmap <leader>ph <Plug>(PickerHelp)

" normal/insert
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle

"more mnemoic gitgutter shortcuts for hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)

"have shift+3 be # (previous shift+3 was £, alt+3 was #)
inoremap £ #
"type backticks with crtl+z
inoremap  `

""""""""""""""""
"plugin settings
"enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
"suggested way to manage ncm2 popups, see :help Ncm2PopupOpen
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone
"use <TAB> to select the ncm2 popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>jf :<C-u>call JuliaFormatter#Format(0)<cr>
vnoremap <leader>jf :<C-u>call JuliaFormatter#Format(1)<cr>
let g:JuliaFormatter_options = {'style': 'blue'}

"close documentation preview window after autocomplete
augroup preview
    autocmd!
    autocmd CompleteDone * pclose
augroup END

"send code to repl in tmux pane
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.tmux/slime_paste"
"default for split tmux window, vim in one pane sending to repl in other pane
let g:slime_default_config = {
\   "socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}

let g:ale_completion_enabled = 1
let g:ale_open_list = 1
"see ale status in nicer format
let g:airline#extensions#ale#enabled = 1
"bind l for lint to fixing ALE problems
nmap <leader>l <Plug>(ale_fix)
"rely on black for all python formatting
let g:ale_fixers = {'python': ['black']}
"use black convention of line length 88
let g:ale_python_flake8_options = '--max-line-length 88'
"two blank lines fine in python, julia adn text files
let g:topiary_ft_allow_two_blank_lines = ['python', 'julia', 'markdown', 'toml', 'raw']

"airline status/tabline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1

"highlight YAML frontmatter in jekyll
let g:vim_markdown_frontmatter = 1

"use ripgrep for file picker (when not in a git repo)
" let g:picker_find_executable = 'rg'
" let g:picker_find_flags = '--color never --files'

"point to executable (even though julia already on PATH in /usr/local/bin)
let g:ale_julia_executable =
\   '/Applications/Julia-1.6.app/Contents/Resources/julia/bin/julia'

"julia-vim settings - not sure if needed with vim-polyglot
let g:default_julia_version = '1.0'
"automatically substitute unicode for latex in julia
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_eager = 1
let g:latex_to_unicode_suggestions = 1
let g:latex_to_unicode_tab = 1

"get julia-vim to play nicely with delimitmate
" autocmd FileType julia let b:delimitMate_expand_space=0

"use language server for julia completion - not sure if needed with ale
"see https://github.com/JuliaEditorSupport/LanguageServer.jl/wiki/Vim-and-Neovim
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       import StaticLint;
\       import SymbolServer;
\       debug = false;
\       env_path = dirname(Base.active_project());
\       depot_path = "";
\       packages = Dict();
\       server = LanguageServer.LanguageServerInstance(
\           stdin, stdout, debug, env_path, depot_path, Dict()
\       );
\       server.runlinter = true;
\       run(server);
\   ']
\ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> D :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<cr>

"customize colorscheme with brighter comments
augroup colorextend
    autocmd!
    autocmd ColorScheme * call onedark#extend_highlight(
\       "Comment", { "fg": { "cterm": 244 } })
augroup END

colorscheme onedark
