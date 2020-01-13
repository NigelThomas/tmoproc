#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory

# we depend on xmllint to parse the data

apt-get update
apt-get install -y libxml2-utils


su sqlstream -m -c ./getLocalLibs.sh
su sqlstream -m -c ant
$SQLSTREAM_HOME/bin/sqllineClient --run polygonContains.sql

echo ... Downloading project data in the background

nohup ./tmoassets.sh &


