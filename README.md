# Dotfiles

Install [rcm](https://github.com/thoughtbot/rcm#installation), clone this repo and use rcm to symlink the appropriate files to the home directory. To include the vim plugin submodules use the `--recursive` flag when cloning.

```sh
git clone https://github.com/nickrobinson251/dotfiles.git ~/.dotfiles --recursive
cd ~/.dotfiles
rcup -v -x README.md
```
