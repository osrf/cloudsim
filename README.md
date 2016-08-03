# README #

This is the Cloudsim meta repository.

## Install tools ##

Install basic tools
`apt install -y sudo curl mercurial git python-pip`

install vcs, a tool to manage multiple repositories
`sudo apt install python-vcstool`

install nodejs (must be version 4 and up)

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install -y nodejs`

install global node modules:

Bower, the package manager for the browser components
`npm install -g bower`

Gulp, the web 'make'
`npm install -g gulp`

Polymer
`npm install -g polymer-cli`

Note: when installing npm modules, you shouldn't have to be the root user.
Npm installs packages locally (in the node_modules directory located besides
 the package.json file). However when you install global packages (with npm -g),
it can happen that npm fails because it wants to write in /usr/bin or somewhere.
For those cases, you should use sudo.

## Get cloudsim sources ##

Run the build.bash to get the sources, and create links accross projects.

`build.bash` does many things, and they could fail.

1. The vcs import command clones
all the repos, so make sure you have ssh setup with bitbucket and github.

1. The `create link` and `use link` scripts allow you to modify code in the repos
instead of "installing" the components. For example, if you type:
`ls -l cloudsim-widgets/app/bower_components/`
You should notice that gz-token is a link to the `gz-token` repo. This is explained
below:

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

## Clients (web apps) ##

1. Cloudsim-widgets: The Cloudsim app
1. gz-* webcomponents for the UI / Ajax

## Configuration ##

Clients and servers can have a .env file for configuration. This file is not under
source control.


1. cloudsim-widgets:

Cloudsim-widget needs to know where the auth server and the portal servers are located.
If you are not working against local versions of the servers, you can use the public ones.  This is an example of the .env file in cloudsim-widget that uses the beanstalk servers:

`
CLOUDSIM_AUTH_URL=https://107.22.153.254:4000

CLOUDSIM_PORTAL_URL=https://cloudsimportal-env.us-east-1.elasticbeanstalk.com:4000
`



### Get in touch  ###

Repo admin: hugo@hugomatic.ca
