# Dotfiles

Install [rcm](https://github.com/thoughtbot/rcm), clone this repo, and use rcm to
symlink the appropriate files to the home directory.

```sh
git clone https://github.com/nickrobinson251/dotfiles.git ~/.dotfiles --recursive
cd ~/.dotfiles
env RCRC=tag-rcm/rcrc rcup
```

Make sure [neovim](https://neovim.io/),
[tmux](https://github.com/tmux/tmux/wiki), and Python 3 are installed, and that
neovim supports Python 3. For example on macOS with
[homebrew](https://brew.sh/), run

```sh
brew install neovim python3 tmux reattach-to-user-namespace
pip3 install --upgrade neovim
```

Install other common tools e.g.
```sh
brew install ripgrep fzy tldr bat tree
```

Add new neovim plugins with [vim-plug](https://github.com/junegunn/vim-plug)
like
```vim
# ~/.config/nvim/init.vim
call plug#begin()
Plug 'tpope/vim-sensible'
call plug#end()
```
then `rcup`, `:PlugUpdate`, and `:source $MYVIMRC`.

Add new tmux plugins with [tpm](https://github.com/tmux-plugins/tpm) like
```conf
# ~/.tmux.conf
set -g @plugin 'tmux-plugins/tmux-sensible'
run '~/.tmux/plugins/tpm/tpm'
```
