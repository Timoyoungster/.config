#!/bin/env zsh

# TODO: finish the install script

essential_packages=(

	# - linux base
	base
	base-devel
	grub
	efibootmgr
	zsh

	# - firmware
	# amd-ucode
	# intel-ucode
	#
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

	# - browser
	qutebrowser
	rofi # for password selection

	# - wayland
	hyprland
	polkit
	hyprpolkitagent
	egl-wayland
	wl-clipboard
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	brightnessctl
	hyprpaper
	hyprlock
	hyprcursor
	mako
	# tofi [aur]

	# - text processing
	neovim
	jq
	# q [aur]

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

	# - utils
	btop
	tmux
	fzf
	gdb
	pdftk
	qpwgraph
	unzip
	# ripgrep [aur]
	
	# - dev utils
	# volta [aur]

	# - games
	bsd-games
)

# - networking
# sudo systemctl enable NetworkManager
# sudo systemctl enable systemd-resolved
# sudo systemctl enable ufw

# - flatpak
# flatpak install com.infinipaint.infinipaint
