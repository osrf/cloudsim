#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo -e "\e[0;33mCloning / updating repositories...\033[0m"
vcs import < repositories

echo -e "\e[0;33mInstalling cloudsim-auth...\033[0m"
(cd cloudsim-auth && npm install)

echo -e "\e[0;33mInstalling cloudsim-grant...\033[0m"
(cd cloudsim-grant && npm install)

echo -e "\e[0;33mInstalling cloudsim-keys...\033[0m"
(cd cloudsim-keys && npm install)

echo -e "\e[0;33mInstalling cloudsim-portal...\033[0m"
(cd cloudsim-portal && npm install)

echo -e "\e[0;33mInstalling cloudsim-sim...\033[0m"
(cd cloudsim-sim && npm install)

echo -e "\e[0;33mInstalling cloudsim-widgets...\033[0m"
(cd cloudsim-widgets && npm install && bower install)

echo -e "\e[0;33mCreating bower links...\033[0m"
./bower_create_links.bash

echo -e "\e[0;33mCreating npm links...\033[0m"
sudo ./npm_create_links.bash

echo -e "\e[0;33mUsing npm links...\033[0m"
(cd cloudsim-auth && ../npm_use_links.bash)
(cd cloudsim-keys && ../npm_use_links.bash)
(cd cloudsim-portal && ../npm_use_links.bash)
(cd cloudsim-sim && ../npm_use_links.bash)
(cd cloudsim-widgets && ../bower_use_links.bash)
