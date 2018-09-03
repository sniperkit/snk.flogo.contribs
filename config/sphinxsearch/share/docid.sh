#!/bin/bash

DOCID="1"
line=""
while read -r line
do
    echo -e "$DOCID \t $line"
    let DOCID=DOCID+1
done </datasets/csv/projects.csv > /datasets/csv/projects.csv
