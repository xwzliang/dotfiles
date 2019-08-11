#!/usr/bin/env bash

# Add repos using ppsh -p 49278 broliang@xwzliang.fun
ppa_to_add=(
	bitcoin/bitcoin
)
for app in "${ppa_to_add[@]}"; do
	if ! grep -q "^deb .*${app}" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
		# commands to add the ppa ...
		add-apt-repository ppa:${app} -y
	fi
done

apt-get update

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
	elinks	# Full-Featured Text web Browser, advanced and well-established feature-rich text mode web browser
	python3-lxml
	build-essential libtool autotools-dev automake pkg-config bsdmainutils	# Bitcoin Core Build Required
	libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev	# Bitcoin Core dependencies
	libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev	# Bitcoin Core qt5
	libdb4.8-dev libdb4.8++-dev		# libdb_cxx via ppa: required by Bitcoin Core build
	proxychains
	shadowsocks-libev
	expect	# a language that talks with your interactive programs or scripts that require user interaction
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


# Clone repository using git

declare -A repos_git_clone

repos_git_clone=(
	["$HOME/.tmux/plugins/tpm"]="https://github.com/tmux-plugins/tpm"
	["$HOME/bitcoin"]="https://github.com/bitcoin/bitcoin.git"
)

for directory_git_local in "${!repos_git_clone[@]}"; do
	if [ ! -d $directory_git_local ]; then
		echo -e "${directory_git_local} not exists, will clone it using git\n"
		proxychains git clone ${repos_git_clone[$directory_git_local]} $directory_git_local
	else
		echo -e "${directory_git_local} already exists, will skip it"
	fi
done


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
