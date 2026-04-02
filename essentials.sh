#!/bin/env zsh

useradd -m -G adm,ftp,games,http,log,rfkill,sys,systemd-journal,uucp,wheel -s /bin/zsh timo

if [[ -d ~/github/yay ]]; then
	echo "yay already installed"
else
	echo "installing yay"
	mkdir ~/github
	git clone https://aur.archlinux.org/yay.git ~/github/yay
	cd ~/github/yay
	makepkg -si
fi

essential_packages=(

	# - linux base
	base
	base-devel
	grub
	efibootmgr
	zsh

	# - firmware [select one]
	# amd-ucode
	# intel-ucode
	# nvidia
	# nvidia-utils
	
	# - help stuff
	man-db
	man-pages
	texinfo

	# - package management
	# yay [manual]
	flatpack

	# - networking
	networkmanager
	openssh
	ufw
	mtr

	# - browser
	qutebrowser
	rofi # for password selection

	# - wayland
	hyprland
	polkit
	hyprpolkitagent
	hyprshutdown # graceful shutdown
	egl-wayland
	wl-clipboard
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	brightnessctl
	hyprpaper
	hyprlock
	hyprcursor
	hyprshot
	mako
	tofi # [aur]

	# - text processing
	neovim
	jq
	q # [aur]

	# - image processing
	# infinipaint [flatpak]
	imv
	imagemagick
	chafa # cli images

	# - audio processing
	pipewire
	pipewire-docs
	pipewire-alsa
	pipewire-jack
	pipewire-pulse
	playerctl

	# - document processing
	zathura
	zathura-pdf-mupdf

	# - utils
	btop
	tmux
	fzf
	gdb
	pdftk
	csvlens
	qpwgraph
	unzip
	ripgrep # [aur]
	pcloudcc-lneely # [aur]
	ttf-cascadia-code
	
	# - dev utils
	volta # [aur]

	# - games
	bsd-games
	steam
	gamemoderun
	mangohud
)

yay -S --needed --noconfirm "${essential_packages[@]}"

# - networking
# sudo systemctl enable NetworkManager
# sudo systemctl enable systemd-resolved
# sudo systemctl enable ufw

# - flatpak
# flatpak install com.infinipaint.infinipaint
