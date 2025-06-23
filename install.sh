#!/usr/bin/env bash

dir="$( cd "$(dirname "$0")" ; pwd -P )"

# Create link to the home dir dotfiles
for config_file in $dir/*symlink*; do
    config_name=$(basename $config_file)
    if [[ $config_name =~ ".symlink" ]]; then
        name_in_home_dir=.`echo $config_name | sed 's/.symlink//'`
        config_home_path=$HOME/$name_in_home_dir
    fi
    if [[ $config_name =~ "_symlink_" ]]; then
        # Split string using delimeter that is not space or special characters
        # arrIN=(${IN//;/ })
        # This construction replaces all occurrences of ';' (the initial // means global replace) in the string IN with ' ' (a single space), then interprets the space-delimited string as an array (that's what the surrounding parentheses do).
        split_name=(${config_name//'_symlink_'/ })
        folder_name=.${split_name[0]}
        name_in_home_dir=$(echo ${split_name[1]} | sed "s|_dir_|/|g" )
        config_home_path=$HOME/$folder_name/$name_in_home_dir
        mkdir -p $HOME/$folder_name
    fi
    # if config file already exists, print a message
    if [ -f $config_home_path ]; then
        echo "$name_in_home_dir already exists, won't overrite it!".
    else
        # make symlinks
        ln -sf $config_file $config_home_path
    fi
done

# source files
#!/bin/bash

FILES=($HOME/.bashrc $HOME/.zshrc)
LINE='source ~/.all_sh_aliases'

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        if ! grep -Fxq "$LINE" "$file"; then
            echo "$LINE" >> "$file"
            echo "Added '$LINE' to $file"
        else
            echo "'$LINE' already exists in $file"
        fi
    else
        echo "$file does not exist"
    fi
done

echo "Finished"
