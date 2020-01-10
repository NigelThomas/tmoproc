#!/bin/bash
# Start the test environment (based on streamlab-git image)

HERE=$(cd `dirname $0`; pwd)
BASE_IMAGE=sqlstream/streamlab-git
CONTAINER_NAME=tmotest

. $HERE/dockercommon.sh
