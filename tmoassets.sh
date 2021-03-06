#!/bin/bash
# get the containers data
# depends on curl to for HTTP fetch and xmllint to break down the XML fetched

mkdir data

curl -s -o containers.xml 'https://tmoassettracker.blob.core.windows.net/?comp=list&sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-01-16T17:32:20Z&st=2019-11-20T09:32:20Z&spr=https&sig=%2BTVWRZiN7ufX4fUWZfxnuj56sHkDwn1qrRS6fQTWLlw%3D'

# edit the file to remove the script which upsets xmllint

sed '/AddEventListener/d' containers.xml

# get the container name

CONTAINER_NAME=$(xmllint --xpath "string(//Name)" containers.xml)

echo getting blobs for $CONTAINER_NAME

# get the list of blobs

URL="https://tmoassettracker.blob.core.windows.net/${CONTAINER_NAME}?restype=container&comp=list&sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-01-16T17:32:20Z&st=2019-11-20T09:32:20Z&spr=https&sig=%2BTVWRZiN7ufX4fUWZfxnuj56sHkDwn1qrRS6fQTWLlw%3D"

echo $URL
rm blobs.xml

curl -s -o blobs.xml $URL

#rm ${CONTAINER_NAME}.json

let serial=1000000

for BlobName in $(xmllint --xpath "//Blobs/Blob/Name/node()" blobs.xml | sed -e 's/json/json /g')
do
    #echo ${BlobName}
    URL="https://tmoassettracker.blob.core.windows.net/tmoassetlog/${BlobName}?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-01-16T17:32:20Z&st=2019-11-20T09:32:20Z&spr=https&sig=%2BTVWRZiN7ufX4fUWZfxnuj56sHkDwn1qrRS6fQTWLlw%3D"
    f=${serial}--${BlobName}
    curl -s $URL > data/$f
    timestring=$(jq .Time data/$f | sed -e "s/ /_/g" -e s'/"//g' -e 's:/:-:g' -e 's/:/./g')

    mv data/$f data/${timestring}-$f
    echo ${timestring}-$f

    let serial++
done

echo completed output in `pwd`/data
