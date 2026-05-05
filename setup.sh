#!/bin/zsh

if [[ -z $SUDO_HOME ]]; then
	USER_HOME=$HOME
else
	USER_HOME=$SUDO_HOME
fi

ln -s $USER_HOME/.config/zsh/.zshrc $USER_HOME/.zshrc
ln -s $USER_HOME/.config/.gitconfig $USER_HOME/.gitconfig
ln -s $USER_HOME/.config/task/taskrc $USER_HOME/.taskrc
ln -s $USER_HOME/.config/scripts/batcheck /usr/local/bin/batcheck
ln -s $USER_HOME/.config/scripts/vpn /usr/local/bin/vpn
ln -s $USER_HOME/.config/scripts/work /usr/local/bin/work
ln -s $USER_HOME/.config/gdb/.gdbinit $USER_HOME/.gdbinit
ln -s $USER_HOME/.config/mimeapps.list $USER_HOME/.local/share/applications/mimeapps.list
ln -s $USER_HOME/.config/applications $USER_HOME/.local/share/applications

mkdir -p $USER_HOME/.local/share/qutebrowser/userscripts
ln -s $USER_HOME/.config/qutebrowser/custom-1pass $USER_HOME/.local/share/qutebrowser/userscripts/custom-1pass

mkdir git
touch git/.gitconfig
ln -s $USER_HOME/.config/git/.gitconfig $USER_HOME/.gitconfig 
echo "Please setup your .gitconfig manually"

mv nchat nchat.old
echo "To setup nchat, please go through the setup process first. After that, close it and move the contents of ./nchat.old back into ./nchat"

if [[ $(which nvim 2> /dev/null ) ]] then
	ln -s $(which nvim) /usr/local/bin/vim
fi
