#!/usr/bin/env zsh
git config --global user.name "Srinivas Hegde M"
git config --global user.email "hegdesrinivasm@gmail.com"
git config --global core.editor "code --wait"

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.lg "log --graph --oneline --decorate --all"
git config --global alias.unstage "reset HEAD --"
git config --global alias.aa "add ."

GLOBAL_IGNORE="$HOME/.gitignore_global"
