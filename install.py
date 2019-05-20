#!/usr/bin/python3

import os
import glob

pwd = os.path.dirname(os.path.realpath(__file__))
os.chdir(pwd)

config_files = glob.glob(os.path.join(pwd, '**', '*symlink*'), recursive=True)
home_dir = os.path.expanduser("~")

print(config_files)

# Create link to the home dir dotfiles
for config_file in config_files:
    config_name = os.path.basename(config_file)
    if '.symlink' in config_name:
        name_in_home_dir = '.' + config_name.replace('.symlink', '')
        config_home_path = os.path.join(home_dir, name_in_home_dir)
    elif '_symlink_' in config_name:
        folder_name = '.' + config_name.split('_symlink_')[0]
        name_in_home_dir = config_name.split('_symlink_')[1]
        config_home_path = os.path.join(home_dir, folder_name, name_in_home_dir)
    # if config file already exists, print a message
    if os.path.exists(config_home_path):
        print("{} already exists, won't overrite it!".format(name_in_home_dir))
    else:
        # make smylinks
        os.system("ln -sf {} {}".format(config_file, config_home_path))

print("Finished")
