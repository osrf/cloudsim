#!/usr/bin/env bash

echo 'bower modules'
bower info osrf/gz-accounts
bower info osrf/gz-cmd
bower info osrf/gz-grant
bower info osrf/gz-machinetypes
bower info osrf/gz-resources
bower info osrf/gz-simulationlauncher
bower info osrf/gz-simulationq
bower info osrf/gz-simulator
bower info osrf/gz-simulatorlauncher
bower info osrf/gz-simulatorq
bower info osrf/gz-token
echo 'npm modules'
echo 'npm view cloudsim-grant version'
npm view cloudsim-grant version
