#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo -e "\e[0;33mCreating bower links...\033[0m"
./bower_create_links.bash

echo -e "\e[0;33mCreating npm links...\033[0m"
sudo ./npm_create_links.bash

echo -e "\e[0;33mUsing npm links...\033[0m"
(cd cloudsim-auth && ../npm_use_links.bash)
(cd cloudsim-keys && ../npm_use_links.bash)
(cd cloudsim-portal && ../npm_use_links.bash)
(cd cloudsim-sim && ../npm_use_links.bash)
(cd cloudsim-widgets && ../npm_use_links.bash)
(cd cloudsim-widgets && ../bower_use_links.bash)
