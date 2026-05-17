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
	bluez
	bluez-utils

	# - browser
	qutebrowser
	firefox
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
	batsignal
	hyprpaper
	hyprlock
	hyprcursor
	hyprshot
	mako
	tofi # [aur]
	greetd
	greetd-tuigreet

	# - text processing
	neovim
	tree-sitter-cli
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
	quarto-cli-bin # [aur]

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
	1password # [aur]
	1password-cli # [aur]
	
	# - dev utils
	volta # [aur]
	hyperfine
	ghostty

	# - social
	nchat # [aur]
	discord # [aur]
	aerc

	# - games
	bsd-games
	steam
	gamemoderun
	mangohud
)

yay -S --needed --noconfirm "${essential_packages[@]}"

# - networking
# sudo systemctl enable NetworkManager # assumed to have been from the live env already
sudo systemctl enable systemd-resolved
sudo systemctl enable bluetooth
sudo systemctl enable ufw
sudo systemctl enable greetd

# setup greetd
sudo sed -i 's/^command = .*$/command = "tuigreet --cmd start-hyprland"/' /etc/greetd/config.toml

# - flatpak
flatpak install com.infinipaint.infinipaint
