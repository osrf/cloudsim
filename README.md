This is the Cloudsim meta repository. It provides tools to install and run the
cloudsim project, which is composed of several repositories.

# Repositories summary #

## Servers ##

1. [ ![Codeship Status for osrf/cloudsim-auth](https://codeship.com/projects/d48e5670-0c06-0134-283f-368b7d3cc702/status?branch=default)](https://codeship.com/projects/156010) [Cloudsim-auth](https://bitbucket.org/osrf/cloudsim-auth): This is the authentication server.
1. [ ![Codeship Status for osrf/cloudsim-sim](https://codeship.com/projects/c1074290-4c5e-0134-4ebf-52026d0c47d6/status?branch=default)](https://codeship.com/projects/170204) [Cloudsim-sim](https://bitbucket.org/osrf/cloudsim-sim): This is the simulation controller server.
1. [ ![Codeship Status for osrf/cloudsim-portal](https://codeship.com/projects/915a1070-0a4d-0134-bce0-06f29080c625/status)](https://codeship.com/projects/155557) [Cloudsim-portal](https://bitbucket.org/osrf/cloudsim-portal): This is the server which manages cloud machines (i.e. Cloudsim-sims).
1. [ ![Codeship Status for osrf/cloudsim-grant](https://codeship.com/projects/5c4c7e80-0c07-0134-008b-368b7d3cc702/status?branch=default)](https://codeship.com/projects/156011) [Cloudsim-grant](https://bitbucket.org/osrf/cloudsim-grant): This is a server component for access control and database.

## Clients (web apps) ##

1. [ ![Codeship Status for osrf/cloudsim-widgets](https://codeship.com/projects/17ac82b0-0e62-0134-df85-7ab2ad815cc6/status?branch=default)](https://codeship.com/projects/156369) [Cloudsim-widgets](https://bitbucket.org/osrf/cloudsim-widgets): The Cloudsim app
1. [gz-*](https://github.com/osrf?utf8=%E2%9C%93&query=gz-): webcomponents for the UI / Ajax

    * [ ![Codeship Status for osrf/gz-accounts](https://codeship.com/projects/482159d0-1ae6-0134-e1c3-0e8ad2af7d49/status?branch=master)](https://codeship.com/projects/159498) [gz-accounts](https://github.com/osrf/gz-accounts)
    * [ ![Codeship Status for osrf/gz-cmd](https://codeship.com/projects/03132470-1ae6-0134-0f10-0e8ad2af7d49/status?branch=master)](https://codeship.com/projects/159495) [gz-cmd](https://github.com/osrf/gz-cmd)
    * [ ![Codeship Status for osrf/gz-grant](https://codeship.com/projects/2fadd1c0-1ae6-0134-6f11-0e8ad2af7d49/status?branch=master)](https://codeship.com/projects/159497) [gz-grant](https://github.com/osrf/gz-grant)
    * [gz-simulationlauncher](https://github.com/osrf/gz-simulationlauncher)
    * [ ![Codeship Status for osrf/gz-simulationq](https://codeship.com/projects/4a474a60-2794-0134-e82d-3ecd098fa328/status?branch=master)](https://codeship.com/projects/162319) [gz-simulationq](https://github.com/osrf/gz-simulationq)
    * [gz-simulator](https://github.com/osrf/gz-simulator)
    * [ ![Codeship Status for osrf/gz-simulatorlauncher](https://codeship.com/projects/ca6e4b90-26dd-0134-ec6c-0ee1950dc067/status?branch=master)](https://codeship.com/projects/162140) [gz-simulatorlauncher](https://github.com/osrf/gz-simulatorlauncher)
    * [ ![Codeship Status for osrf/gz-simulatorq](https://codeship.com/projects/2cc0c8d0-26de-0134-b77a-166eddd0a5f8/status?branch=master)](https://codeship.com/projects/162141) [gz-simulatorq](https://github.com/osrf/gz-simulatorq)
    * [ ![Codeship Status for osrf/gz-token](https://codeship.com/projects/a4a3e170-1ae3-0134-a64a-265a91e3d879/status?branch=master)](https://codeship.com/projects/159492) [gz-token](https://github.com/osrf/gz-token)

# Installation #

## Install dependencies ##

Install basic tools

  ` sudo apt get install -y curl mercurial git python-pip`

Install vcs, a tool to manage multiple repositories

   `sudo apt-get install python-vcstool`

Install nodejs (must be version 4 and up)

    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt install -y nodejs

Install global node modules:

Bower, the package manager for the browser components

   `npm install -g bower`

Gulp, the web 'make'

   `npm install -g gulp`

Polymer

   `npm install -g polymer-cli`

> Note: when installing npm modules, you shouldn't have to be the root user.
> Npm installs packages locally (in the node_modules directory located besides
> the package.json file). However when you install global packages (with npm -g),
> it can happen that npm fails because it wants to write in /usr/bin or somewhere.
> For those cases, you should use sudo.

## Get and link cloudsim source code ##

Run `build.bash` to get the sources, and create links accross projects.

    bash build.bash

`build.bash` does many things, and they could fail.

1. The vcs import command clones all the repos, so make sure you have ssh setup
with bitbucket and github.

1. The `create link` and `use link` scripts allow you to modify code in the repos
instead of "installing" the components. For example, if you type:
`ls -l cloudsim-widgets/app/bower_components/`
You should notice that gz-token is a link to the `gz-token` repo. This is explained
below:

### Projects and links explained ###

Cloudsim uses 2 javascript package managers: npm for server side components and
servers, and bower for client side web components.

Packages can either be installed or linked.

1. Installled packages are downloaded and installed from versioned tar balls,
and are useful for production.

1. Linked packages allow you to use local copies of repositories, and are
useful for development.

The `build.bash` script links the cloudsim packages:

1. `bower_create_links` advertizes the client repositories
1. `bower_use_links` subscribes to the server repositories

## Configuration ##

Clients and servers can have a `.env` file for configuration. This file is not
under source control.

### Cloudsim-grant ###

No config necesary, but you can use it to generate authentication keys for the
authentication server:

    $node
    > const csgrant = require('cloudsim-grant')
    > const keys = csgrant.token.generateKeys()
    > keys
    { private: '-----BEGIN RSA PRIVATE KEY-----\nMIIBOQIBAAJBAIl+bpv62gw3LbtNPZs7LU3gRLpNAtaKeD4bZ5So0RmyXSiMa/AK\nJ8gZ2zZ33NhoHJ47i7AS48OhC4VmSHXETbUCAQUCQG3+vuMvFNaSivw9yuKVvdfm\nnWHXNXhuxpgV7HbtdBSNhF+wAAJ79iCXA82TeotISHxvDs5glrFOXJG69SQLjM0C\nIQDFM4+P44uIgaoAtWbcjAcdokC4IJ8b36yuTlBIij1RtQIhALJ9YNwJY6udsxXA\nGKceRqRgcAENewuGUmmA7E1+eIwBAiEAncLZP+k8bTSIAJEfFtZsF7UAk01MFkyK\nJQtzbTtkQV0CIQCOyrPjOrYi5I9Ema1Sfp7p5sAA15Wi0duHmlakZS08zQIgaU8T\n2vgd3YoM4k0wiCVxgIDY2qA7ZOWDFtNF8pEkQqE=\n-----END RSA PRIVATE KEY-----',
      public: '-----BEGIN PUBLIC KEY-----\nMFowDQYJKoZIhvcNAQEBBQADSQAwRgJBAIl+bpv62gw3LbtNPZs7LU3gRLpNAtaK\neD4bZ5So0RmyXSiMa/AKJ8gZ2zZ33NhoHJ47i7AS48OhC4VmSHXETbUCAQU=\n-----END PUBLIC KEY-----' }

### Cloudsim-widgets ###

Cloudsim-widgets needs to know where the auth server and the portal servers are located.
If you are not working against local versions of the servers, you can use the public ones.
This is an example of the `.env` file in Cloudsim-widgets that uses the beanstalk servers:

    CLOUDSIM_AUTH_URL=https://107.22.153.254:4000
    CLOUDSIM_PORTAL_URL=https://cloudsimportal-env.us-east-1.elasticbeanstalk.com:4000

### Cloudsim-portal ###

Cloudsim-portal needs AWS access keys in order to launch machines. It also needs
Cloudsim-auth's public key to decode webtokens. See more information
here.
The `.env`file will have the following:

    CLOUDSIM_AUTH_PUB_KEY=
    AWS_SECRET_ACCESS_KEY=
    AWS_ACCESS_KEY_ID=


### Cloudsim-auth ###

Cloudsim-auth needs the following keys for webtoken decoding:

    CLOUDSIM_AUTH_PUB_KEY=
    CLOUDSIM_AUTH_PRIV_KEY=

# Development process #

## Cloudsim-auth ##

### Updates ###

* Pull request to cloudsim-auth
* Once merged into default, public server is redeployed by Codeship.

### Impacted repos ###

The following repos might need code updates or redeployment to take
cloudsim-auth changes into account.

* [cloudsim-portal](https://bitbucket.org/osrf/cloudsim-portal)
* [cloudsim-widgets](https://bitbucket.org/osrf/cloudsim-widgets)
* [cloudsim-sim](https://bitbucket.org/osrf/cloudsim-sim)
* gz-token

## Cloudsim-grant ##

### Updates ###

* Pull request to [cloudsim-grant](https://bitbucket.org/osrf/cloudsim-grant). The version number in `package.json` must be
increased.
* Someone with enough permissions must run `npm publish`.

### Impacted repos ###

The following repos might need code updates or redeployment to take
cloudsim-grant changes into account.

* [cloudsim-sim](https://bitbucket.org/osrf/cloudsim-sim)
* [cloudsim-portal](https://bitbucket.org/osrf/cloudsim-portal)

## Cloudsim-portal ##

### Updates ###

* Pull request to [cloudsim-portal](https://bitbucket.org/osrf/cloudsim-portal)
* Once merged into default, public server is redeployed by Codeship.

### Impacted repos ###

The following repos might need code updates or redeployment to take
cloudsim-portal changes into account.

* [cloudsim-sim](https://bitbucket.org/osrf/cloudsim-sim)
* [cloudsim-widgets](https://bitbucket.org/osrf/cloudsim-widgets)
* [gz-XXX](https://github.com/osrf/?utf8=%E2%9C%93&query=gz-)

## Cloudsim-sim ##

### Updates ###

* Pull request to [cloudsim-sim](https://bitbucket.org/osrf/cloudsim-sim)
* Once merged into default, someone needs to ssh into a live machine to pull
the new code and then make a new ami.
* Then add the new ami to the list in
`cloudsim-widgets/app/elements/cs-machinelauncher/cs-machinelauncher.html`

### Impacted repos ###

The following repos might need code updates or redeployment to take
cloudsim-sim changes into account.

* [cloudsim-widgets](https://bitbucket.org/osrf/cloudsim-widgets)
* [gz-XXX](https://github.com/osrf/?utf8=%E2%9C%93&query=gz-)

## gz-XXX ##

### Updates ###

* Pull request to [gz-XXX](https://github.com/osrf/?utf8=%E2%9C%93&query=gz-).
* Once merged into default, make a new release through GitHub.

### Impacted repos ###

The following repos might need code updates or redeployment to take
gz-XXX changes into account.

* [cloudsim-widgets](https://bitbucket.org/osrf/cloudsim-widgets)

# Get in touch  #

Repo admin: hugo@hugomatic.ca
