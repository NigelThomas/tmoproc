#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory

# we depend on xmllint to parse the data

apt-get update
apt-get install -y libxml2-utils


echo ... Downloading project data in the background

nohup ./tmoassets.sh &


