#!/bin/bash

# the folders
ICONS=Colloid-icon-theme/
SHELL_THEME=Marble-shell-theme/
CURSOR=Qogir-Recolored-Catppuccin-Macchiato/

setup(){
	echo "Changing the settings gtk"
	sudo gsettings set org.gnome.desktop.interface gtk-theme "Marble-blue-dark"
	echo "Changing the settings icons"
	gsettings set org.gnome.desktop.interface icon-theme 'Colloid'
	echo "Changing the settings cursor"
	gsettings set org.gnome.desktop.interface cursor-theme "Qogir-Recolored-Catppuccin-Macchiato"

}

installing(){
	if [ -f "$PWD/$ICONS/install.sh" ]; then
		echo "Repo downloaded, running install.sh"; echo ""
		bash $ICONS/install.sh
	elif [ -d "$PWD/$ICONS" ]; then
		echo "Replacing directory"; echo ""
		rm -r $PWD/$ICONS
		echo "Downloading Repo"; echo ""
		git clone https://github.com/vinceliuice/Colloid-icon-theme.git
		echo "running install.sh"; echo ""
		bash $ICONS/install.sh
	else
		echo "Downloading Repo"; echo ""
		git clone https://github.com/vinceliuice/Colloid-icon-theme.git
		echo "running install.sh"; echo ""
		bash $ICONS/install.sh
	fi
	echo "Icon theme installed"; echo ""
	
	if [ -f "$PWD/$SHELL_THEME/install.py" ]; then
		echo "Repo downloaded, running install.py -a"; echo ""
		cd $SHELL_THEME
		sudo python3 install.py -a
		cd ..
	elif [ -d "$PWD/$SHELL_THEME" ]; then
		echo "Replacing directory"; echo ""
		rm -r $PWD/$SHELL_THEME
		echo "Downloading Repo"; echo ""
		git clone https://github.com/theolaos/Marble-shell-theme.git
		echo "running install.py -a"; echo ""
		cd $SHELL_THEME
		sudo python3 install.py -a
		cd ..
	else
		echo "Downloading Repo"; echo ""
		git clone https://github.com/theolaos/Marble-shell-theme.git
		echo "running install.py -a"; echo ""
		cd $SHELL_THEME
		sudo python3 install.py -a
		cd .. 
		#sudo python3 $SHELL_THEME/install.py -a
	fi
	echo "Shell theme installed"; echo ""

	ROOT_UID=0
	DEST_DIR=

	# Destination directory
	if [ "$UID" -eq "$ROOT_UID" ]; then
  		DEST_DIR="/usr/share/icons"
	else
  		DEST_DIR="$HOME/.local/share/icons"
	fi

	if [ -d "$DEST_DIR/$CURSOR" ]; then
		# replacing existing one
		echo "replacing existing one"
  		sudo rm -r "$DEST_DIR/$CURSOR"
	fi
	
	
	DISTR=Qogir-Recolored-Catppuccin-Macchiato/
	echo "copying cursor files"
	sudo cp -r $CURSOR $DEST_DIR
	echo "Finished the icon install"; echo ""
	
	# change this so it gets from the git forked repo: https://github.com/TheooKing/Qogir-Cursors-Recolored.git
}

if [ "${1,,}" = "-setup" ]; then
	setup
elif [ "${1,,}" = "-install" ]; then
	installing
elif [ "${1,,}" = "-auto-install" ]; then
	installing
	setup
elif [ "${1,,}" = "-help" ]; then
	echo "	-auto-install : installs and setups everything"
	echo "	-install : installs only the repos or if they are installed runs the install script"
	echo "	-setup : tries to setup the themes"
	echo "	-return-defaults : return to adwaita themes"
	echo "	-help : to get help, this message"
elif [ "${1,,}" = "-return-defaults" ]; then
	echo "Defaulting the settings gtk"
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
	echo "Defaulting the settings icons"
	gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
	echo "Defaulting the settings cursor"
	gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
else
	echo "No clue what you said, type -help do get some help :)"
fi

# check from your desktop 'dconf watch /' and change the shell theme, check the output, change accordingly
