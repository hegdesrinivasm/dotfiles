#Configuring git
git config --global user.name "Srinivas Hegde M"
git config --global user.email "hegdesrinivasm@gmail.com"
git config --global core.editor "code --wait"

#Some helpful Git Aliases
echo "---Adding Aliases ---"
# st = status
git config --global alias.st status
# co = checkout
git config --global alias.co checkout
# ci = commit
git config --global alias.ci commit
# br = branch
git config --global alias.br branch
# lg = nice log graph
git config --global alias.lg "log --graph --oneline --decorate --all"
# unstage = remove files from index
git config --global alias.unstage "reset HEAD --"

echo "Aliases added: st, co, ci, br, lg, unstage"

echo "---Setting up Global .gitignore ---"
GLOBAL_IGNORE="$HOME/.gitignore_global"

# Create file if it doesn't exist
if [ ! -f "$GLOBAL_IGNORE" ]; then
    touch "$GLOBAL_IGNORE"
fi

# Add .DS_Store if not present
if ! grep -q ".DS_Store" "$GLOBAL_IGNORE"; then
    echo ".DS_Store" >> "$GLOBAL_IGNORE"
    echo "Added .DS_Store to global ignore."
fi

git config --global core.excludesfile "$GLOBAL_IGNORE"

echo ""
echo "========================================="
echo "Configuration Complete!"
echo "Current Global Config:"
git config --global --list