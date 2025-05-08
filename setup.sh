ln -s ~/.config/zsh/.zshrc ~/.zshrc

mkdir git
touch git/.gitconfig
ln -s ~/.config/git/.gitconfig ~/.gitconfig 
echo "Please setup your .gitconfig manually"

mv nchat nchat.old
echo "To setup nchat, please go through the setup process first. After that, close it and move the contents of ./nchat.old back into ./nchat"
