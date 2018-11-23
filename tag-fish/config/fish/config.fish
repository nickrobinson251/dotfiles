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

# clear with crtl+n because crtl+l used by vim-tmux-navigator. See:
# github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_shared_key_bindings.fish#L83
bind -M insert $argv \cn \
    'echo -n (clear | string replace \e\[3J ""); commandline -f repaint'

# add abbreviations as global variables because faster than default universal
if status --is-interactive
    set -g fish_user_abbreviations
    abbr -a cdd cd ~/.dotfiles
    abbr -a g git
    abbr -a ga git add
    abbr -a gb git branch
    abbr -a gc git commit
    abbr -a gco git checkout
    abbr -a gd git diff
    abbr -a gr git rebase
    abbr -a gs git status
    abbr -a ta tmux attach -t
    abbr -a tn tmux new -s
    abbr -a ts tmux switch -t
end
