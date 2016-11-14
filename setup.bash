#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo -e "\e[0;33mCloning / updating repositories...\033[0m"
vcs import < repositories

echo -e "\e[0;33mBuilding repositories...\033[0m"
$DIR/build.bash

if [ $# == 1 ] && [ "$1" == link ]; then
  echo -e "\e[0;33mLinking repositories...\033[0m"
  $DIR/build.bash
else
  echo -e "\e[0;33mNot linking repositories, you can run [link.bash] manually.\033[0m"
fi

