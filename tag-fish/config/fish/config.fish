# print directory names in brighter blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

# append anaconda to path so we can use conda
set -gx PATH $HOME/anaconda/bin $PATH

# make using conda virtual envs possible. Start/stop with
# '[conda] activate <env>' and '[conda] deactivate'
source (conda info --root)/etc/fish/conf.d/conda.fish

# make environment name appear on the left side of prompt
set -gx CONDA_LEFT_PROMPT 1

# set neovim as default editor
set -gx VISUAL nvim
set -gx EDITOR nvim
