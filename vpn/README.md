
# SRC and vpn

A computer at OSRF is used to generate the vpn keys for simulation server and "ocu" computers.
This is the "keygen" computer

## keygen computer setup

install.bash has instructions to setup the packages on the keygen computer
download and install cloudsimk and nodejs.



keys files are zipped in tar files and sent to simulation computers and ocu computers.

# Generate keys on the Keygen computer

install.bash has instructions to setup the packages on the keygen computer
setup.bash must be sourced to generate the keys. You must set the EASY_RSA
variable (line 20) to the directory of your easy-rsa program. The default
is ../../src_vpn_keys.


Then, use easy_rsa scripts to generate server and client key. Convention: for server key
name, use src-01, src-02 ... src-xx. You can generate multiple keys per server, using
names like src-01-01, src-01-02.

Once keys are generated, you can make zip files for simulation servers and ocu computers.

## Launch a simulation instance from the keygen computer

  cd cloudsimk/app/lib/

Add your AWS credentials to the environment:

  export AWS_ACCESS_KEY_ID=XXXXXX
  export AWS_SECRET_ACCESS_KEY=XXXXX

Launch an aws instance:

  node launch_sim.js src_start.bash

Note the ip of the server for later use.

## update the simulation server (TODO: update AMI instead)

  cd /home/ubuntu/code/src_cloud_simulator/
  hg revert -a
  hg pull -u
  sudo ./aws/setup_aws.bash

you need to reboot the simulation server.
build containers

  cd /home/ubuntu/code/src_cloud_simulator/docker
  build_all.bash


## Generate openvpn configs for the simulation server

use server.bash to generate a server_vpn.tar.gz file that contains openvpn files for the
simulation server. You must pass in the server key name.

The server_vpn.tar.gz file must be sent to the aws simulation server, in the following location:
/home/ubuntu/code/src_cloud_simulator/aws/server_vpn.tar.gz

This is done with the push_server_key.bash (with the aws private key, remote ip and keys tar file)

ex: push_server_key.bash ~/.ssh/id_rsa 54.32.32.34 server_vpn.tar.gz

## Run simulation container and field computer


on the server, go to
/home/ubuntu/code/src_cloud_simulator/docker

  ./build_all.bash

and to run

  ./run_simulator.bash

  ./run_robot.bash



## Generate key for the OCU and run an OCU in docker

use client.bash to generate an ocu vpn tar file. You must specify the client key name and
the ip address of the server.

  cd src_cloud_simulator/vpn
  client.bash src-01-01 54.32.32.34

the resulting openvpn.tar.gz file can be placed in the docker location:
  cd ../docker
  mv ../vpn/openvpn.tar.gz ../docker/ocu/openvpn.tar.gz

And a container can be created with:
  cd ./build_ocu.bash

TODO: build different ocu for each server.

The ocu can be run with:

  ./run_ocu.bash


## Log in the field computer from the ocu


