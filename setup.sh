#!/bin/zsh

ln -s ~/.config/zsh/.zshrc ~/.zshrc
ln -s ~/.config/.gitconfig ~/.gitconfig
ln -s ~/.config/task/taskrc ~/.taskrc
ln -s ~/.config/scripts/batcheck /usr/local/bin/batcheck
ln -s ~/.config/scripts/vpn /usr/local/bin/vpn
ln -s ~/.config/scripts/work /usr/local/bin/work
ln -s ~/.config/gdb/.gdbinit ~/.gdbinit
ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list
ln -s ~/.config/applications ~/.local/share/applications

mkdir -p ~/.local/share/qutebrowser/userscripts
ln -s ~/.config/qutebrowser/custom-1pass ~/.local/share/qutebrowser/userscripts/custom-1pass

mkdir git
touch git/.gitconfig
ln -s ~/.config/git/.gitconfig ~/.gitconfig 
echo "Please setup your .gitconfig manually"

mv nchat nchat.old
echo "To setup nchat, please go through the setup process first. After that, close it and move the contents of ./nchat.old back into ./nchat"

if [[ $(which nvim 2> /dev/null ) ]] then
	ln -s $(which nvim) /usr/local/bin/vim
fi
