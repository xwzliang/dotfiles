#!/usr/bin/env bash

apps_to_install=(
	vim
	python3
	tmux
	calibre
	aria2
	pandoc
	w3m
	xterm
	imagemagick
	ffmpeg
	mosh
)

for app in "${apps_to_install[@]}"; do
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $app | grep "install ok installed")
	if [ "" == "$PKG_OK" ]; then
		echo -e "${app} not installed, will install it\n"
		apt install -y ${app}
	else
		echo -e "${app} already installed, will skip it"
	fi
done

# git credential settings
read -rn 1 -p "Save git credentials to an unencrypted file to avoid writing? [y/N] " git_save_credential
if [[ $git_save_credential =~ ^([Yy])$ ]]; then
	echo -e "[credential]\nhelper = store\n" > ~/.gitconfig.local
	echo -e "\nWill save git credentials to an unencrypted file"
else
	echo -e "[credential]\nhelper = cache --timeout 7200\n" > ~/.gitconfig.local
	echo -e "\nWill cache credentails for two hours"
fi
