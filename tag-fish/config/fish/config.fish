# ~/.config/fish/config.fish
# no welcome message
set -g fish_greeting

# add vim modes and bindings as well as defaul emacs bindings
set -g fish_key_bindings fish_hybrid_key_bindings

# list current directory in prompt in muted green from vim onedark colorsheme
set -g fish_color_cwd 98c379

# print directory names in brighter blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

# prepend anaconda to path so we can use conda
if not contains $HOME/anaconda/bin $PATH
    set -gx PATH $home/anaconda/bin $PATH
end

# make using conda virtual envs possible
# start/stop using env with 'conda activate <env>' and 'conda deactivate'
if not functions -q __fish_right_prompt_orig
    if test -n "$_CONDA_ROOT"
        source $_CONDA_ROOT/etc/fish/conf.d/conda.fish
    end
end

# make environment name appear on the left side of prompt
set -gx CONDA_LEFT_PROMPT 1

# set neovim as default editor
set -gx VISUAL nvim
set -gx EDITOR nvim

# clear with crtl+o because crtl+l used by vim-tmux-navigator. See:
# github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_shared_key_bindings.fish#L83
bind -M insert $argv \co \
    'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'

# add abbreviations as global variables because faster than default universal
if status --is-interactive
    set -g fish_user_abbreviations
    abbr -a cdd cd ~/.dotfiles
    abbr -a g git
    abbr -a ga git add
    abbr -a gb git branch
    abbr -a gc git commit
    abbr -a gd git diff
    abbr -a gr git rebase
    abbr -a gs git status
end
