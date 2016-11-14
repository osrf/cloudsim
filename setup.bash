#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo -e "\e[0;33mCloning / updating repositories...\033[0m"
vcs import < repositories

$DIR/build.bash

