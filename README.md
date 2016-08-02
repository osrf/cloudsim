# README #

This is the Cloudsim meta repository.

## Install tools ##

Install basic tools
`apt install -y sudo curl mercurial git python-pip`

install vcs, a tool to manage multiple repositories
`sudo apt install python-vcstool`

install nodejs

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install -y nodejs`

install global node modules:

Bower, the package manager for the browser components
`npm install -g bower`

Gulp, the web 'make'
`npm install -g gulp`

Polymer
`npm install -g polymer-cli`


## Get cloudsim sources ##

Run the build.bash to get the sources, and create links accross projects.

## Projects and links ##

Cloudsim uses 2 javascript package managers: npm for server side components and
servers, and bower for client side web components.

Packages can be either be installed or linked.

1. Installled packages are downloaded and installed from versioned tar balls,
and are useful for production.
1. Linked packages allow you to use the code in their repository, and are useful for development.

The build.bash script links the cloudsim packages:

1. bower_create_links advertizes the client repositories
1. bower_use_links subscribes to the server repositories

## Servers ##

1. Cloudsim-auth: This is the authentication server
1. Cloudsim-sim: This is the simulation controller server
1. Cloudsim-portal: This is the cloud machines server
1. Cloudsim-grant: This is a server component for access control and database

## Clients ##

1. Cloudsim-widgets: The Cloudsim app
1. gz-* webcomponents for the UI / Ajax

### Get in touch  ###

Repo admin: hugo@hugomatic.ca
