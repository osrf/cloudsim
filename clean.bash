#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo -e "\e[0;33mCleaning cloudsim-auth...\033[0m"
(cd cloudsim-auth && rm -rf node_modules)

echo -e "\e[0;33mCleaning cloudsim-grant...\033[0m"
(cd cloudsim-grant && rm -rf node_modules)

echo -e "\e[0;33mCleaning cloudsim-keys...\033[0m"
(cd cloudsim-keys && rm -rf node_modules)

echo -e "\e[0;33mCleaning cloudsim-portal...\033[0m"
(cd cloudsim-portal && rm -rf node_modules)

echo -e "\e[0;33mCleaning cloudsim-sim...\033[0m"
(cd cloudsim-sim && rm -rf node_modules)

echo -e "\e[0;33mCleaning cloudsim-widgets...\033[0m"
(cd cloudsim-widgets && n rm -rf node_modules app/bower_components)

