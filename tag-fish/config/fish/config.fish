# ~/.config/fish/config.fish
# no welcome message
set -g fish_greeting

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showupstream "informative"

# add vim modes and bindings as well as defaul emacs bindings
set -g fish_key_bindings fish_hybrid_key_bindings

# list current directory in prompt in muted green from vim onedark colorsheme
set -g fish_color_cwd 98c379

# print directory names in brighter blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

# set neovim as default editor
set -gx VISUAL nvim
set -gx EDITOR nvim

set -gx TF_ALIAS fk
thefuck --alias | source

# INVENIA
set -gx MISO_NDA_BUCKET invenia-miso-nda-5twngkbmrczu6xd9uppda18b5995yuse1a-s3alias

# clear with crtl+n because crtl+l used by vim-tmux-navigator. See:
# github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_shared_key_bindings.fish#L83
bind -M insert $argv \cn \
    'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'

# add abbreviations as global variables because faster than default universal
if status --is-interactive
    set -g fish_user_abbreviations
    abbr -a cdd 'cd ~/.dotfiles'
    abbr -a cdswp 'cd ~/.local/share/nvim/swap'
    abbr -a g 'git'
    abbr -a ga 'git add'
    abbr -a gb 'git branch'
    abbr -a gba 'git branch --all'
    abbr -a gbp 'git branch --merged master | rg -v \'^[ *]*master$\' | xargs git branch -d'
    abbr -a gcm 'git commit'
    abbr -a gco 'git checkout'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'
    abbr -a gf 'git fetch --all'
    abbr -a gfp 'git fetch --all --prune'
    abbr -a glg 'git lg'
    abbr -a gr 'git rebase'
    abbr -a grb 'git rebase -i (git merge-base origin/main HEAD)'
    abbr -a tn 'tmux new -s'
    abbr -a ts 'tmux switch -t'
    abbr -a rgf 'rg --files-with-matches'
    abbr -a rgc 'rg --ignore-case'
    abbr -a rgi 'rg --only-matching "https://gitlab.invenia.ca/\S*/issues/\d+"' # rg issues
end
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths

# Load pyenv and pyenv-virtualenv automatically
pyenv init - | source
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/nick/miniconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
function __conda_add_prompt
    if set -q CONDA_PROMPT_MODIFIER
        set_color -o black
        if [ "$CONDA_PROMPT_MODIFIER" != "(base)" ]
            set_color black
            echo -n $CONDA_PROMPT_MODIFIER
        end
        set_color normal
    end
end
set --erase CONDA_LEFT_PROMPT
