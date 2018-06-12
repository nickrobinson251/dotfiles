# Dotfiles

Install [rcm](https://github.com/thoughtbot/rcm#installation), clone this repo and use rcm to symlink the appropriate files to the home directory.
To include the vim plugin submodules use the `--recursive` flag when cloning.

```sh
git clone https://github.com/nickrobinson251/dotfiles.git ~/.dotfiles --recursive
cd ~/.dotfiles
rcup -v -x README.md
```

Make sure [vim](http://www.vim.org/) supports Python 3. For example on macOS with [homebrew](https://brew.sh/), run

```sh
brew install vim --with-python3
```

Install new vim plugins with [pathogen](https://github.com/tpope/vim-pathogen) using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) like
```sh
cd ~/.dotfiles/vim/bundle
git submodule add git://github.com/tpope/vim-sensible.git
```
then `rcup` and source vimrc.
