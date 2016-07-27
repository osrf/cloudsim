#!/usr/bin/env bash

# get the user to enter sudo password at start
sudo pwd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

vcs import < repositories

(cd cloudsim-auth && npm install)
(cd cloudsim-portal && npm install)
(cd cloudsim-sim && ../npm install)
(cd cloudsim-widgets && npm install && bower install)

./bower_create_links.bash
sudo ./npm_create_links.bash

(cd cloudsim-auth && ../npm_use_links.bash)
(cd cloudsim-portal && ../npm_use_links.bash)
(cd cloudsim-sim && ../npm_use_links.bash)
(cd cloudsim-widgets && ../bower_use_links.bash)
