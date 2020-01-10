# tmopoc

This project represents a POC project.

Data is collected - either from a REST API (see tmoassets.sh) or from a Kafka topic 

## Data ingest from file collected by tmoassets.sh

JSON files are downloaded - 1 record per file - and concatenated into tmoassets.sh

TODO: consider pushing the data into SQLstream (eg using sqlline initially)

The tmoassets.sh file can be ingested by the SQLstream project represented by `tmob.slab`

## Building the project

Use the `streamlab-git` and `streamlab-git-dev` docker images (see `streamlab-git` github repository.


