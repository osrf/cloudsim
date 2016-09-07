#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR


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


