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

if test -n "$_CONDA_ROOT"
    # prepend conda to path if installed
    if not contains $_CONDA_ROOT $PATH
        set -gx PATH $_CONDA_ROOT $PATH
    end
    # make conda environment name appear on the left side of prompt
    set -gx CONDA_LEFT_PROMPT 1
    # enable ability to switch to/from envs with`conda [de]activate <env>'
    if not functions -q __fish_right_prompt_orig
        source $_CONDA_ROOT/etc/fish/conf.d/conda.fish
    end
end

# set neovim as default editor
set -gx VISUAL nvim
set -gx EDITOR nvim

set -gx TF_ALIAS fk
thefuck --alias | source

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
    abbr -a gf 'git fetch'
    abbr -a gfp 'git fetch --prune'
    abbr -a glg 'git lg'
    abbr -a gr 'git rebase'
    abbr -a grb 'git rebase -i (git merge-base  origin/master HEAD)'
    abbr -a gs 'git status'
    abbr -a rgf 'rg --files-with-matches'
    abbr -a ta 'tmux attach -t'
    abbr -a tn 'tmux new -s'
    abbr -a ts 'tmux switch -t'
end
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
