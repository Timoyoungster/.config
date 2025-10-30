#!/bin/zsh

ln -s ~/.config/zsh/.zshrc ~/.zshrc
ln -s ~/.config/task/taskrc ~/.taskrc

mkdir git
touch git/.gitconfig
ln -s ~/.config/git/.gitconfig ~/.gitconfig 
echo "Please setup your .gitconfig manually"

mv nchat nchat.old
echo "To setup nchat, please go through the setup process first. After that, close it and move the contents of ./nchat.old back into ./nchat"

if [[ $(which nvim 2> /dev/null ) ]] then
	ln -s $(which nvim) /usr/local/bin/vim
fi
