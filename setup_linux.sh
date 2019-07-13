#!/usr/bin/env bash

# Install apps using apt
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
	ocrmypdf
	hfsprogs
	rename
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


# Install apps using other methods

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

declare -A apps_other_methods

apps_other_methods=(
	["docker"]="wget -qO- https://get.docker.com/ | sh"
)

for app_other in "${!apps_other_methods[@]}"; do
	if ! command_exists $app_other; then
		echo -e "${app_other} not installed, will install it\n"
		eval ${apps_other_methods[$app_other]}
	else
		echo -e "${app_other} already installed, will skip it"
	fi
done


# Clone TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	echo "Cloning TPM for tmux..."
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi


# git credential settings
git_config_local_file=$HOME/.gitconfig.local
if [ ! -f "$git_config_local_file" ]; then
	read -rn 1 -p "Save git credentials to an unencrypted file to avoid writing? [y/N] " git_save_credential
	if [[ $git_save_credential =~ ^([Yy])$ ]]; then
		echo -e "[credential]\nhelper = store\n" > $git_config_local_file
		echo -e "\nWill save git credentials to an unencrypted file"
	else
		echo -e "[credential]\nhelper = cache --timeout 7200\n" > $git_config_local_file
		echo -e "\nWill cache credentails for two hours"
	fi
fi
