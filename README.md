# Dotfiles

Install [rcm](https://github.com/thoughtbot/rcm), clone this repo, and use rcm to
symlink the appropriate files to the home directory.

```sh
git clone https://github.com/nickrobinson251/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
env RCRC="~/.dotfiles/tag-rcm/rcrc" rcup

```

Make sure [neovim](https://neovim.io/) is installed and supports Python 3.
For example on macOS with [homebrew](https://brew.sh/), run

```sh
brew install neovim python3
pip3 install --upgrade neovim
```

Add new neovim plugins with [vim-plug](https://github.com/junegunn/vim-plug) like
```vim
call plug#begin()
    Plug 'tpope/vim-sensible'
call plug#end()
```
then `rcup`, `:PlugUpdate`, and `:source $MYVIMRC`.
