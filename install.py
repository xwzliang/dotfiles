#!/usr/bin/python3

import os
import glob

pwd = os.path.dirname(os.path.realpath(__file__))
os.chdir(pwd)

config_files = glob.glob(os.path.join(pwd, '**', '*.symlink'), recursive=True)
home_dir = os.path.expanduser("~")

# Create link to the home dir dotfiles
for config_file in config_files:
    file_name = os.path.basename(config_file)
    name_in_home_dir = '.' + file_name.replace('.symlink', '')
    config_home_path = os.path.join(home_dir, name_in_home_dir)
    # if config file already exists, print a message
    if os.path.exists(config_home_path):
        print("{} already exists, won't overrite it!".format(name_in_home_dir))
    else:
        # make smylinks
        os.system("ln -sf {} {}".format(config_file, config_home_path))

print("Finished")
