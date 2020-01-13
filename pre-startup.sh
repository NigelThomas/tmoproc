#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory

# we depend on xmllint to parse the data

apt-get update
apt-get install -y ant libxml2-utils

mkdir -p ./lib
./getLocalLibs.sh
ant
chown -R sqlstream:sqlstream classes libs Polygon.jar

$SQLSTREAM_HOME/bin/sqllineClient --run=polygonContains.sql

echo ... Downloading project data in the background

nohup ./tmoassets.sh &


