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
	libsixel
	ffmpeg
	mosh
)

for app in "${apps_to_install[@]}"; do
	apt install -y ${app}
done
