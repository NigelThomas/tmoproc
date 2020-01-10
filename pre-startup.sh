#!/bin/bash
#
# Do any preproject setup needed before loading the StreamLab projects
#
# Assume we are running in the project directory


echo ... Downloading project data in the background

nohup ./tmoassets.sh &


