#!/bin/bash
while getopts ":r:" arg; do
  case $arg in
    r) REGION=$OPTARG;;
  esac
done
for file in *.yml
    do
        file_noext=${file%.*}
        aws ssm create-document --content file://$file --name "$file_noext" --document-type "Command" --document-format YAML --region $REGION
done
