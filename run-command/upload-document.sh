#!/bin/bash
while getopts ":r:" arg; do
  case $arg in
    r) REGION=$OPTARG;;
    *) echo "usage: $0 [-v] [-r]" >&2
       exit 1 ;;
  esac
done
for file in *.yml
    do
        file_noext=${file%.*}
        aws ssm create-document --content file://$file --name "$file_noext" --document-type "Command" --document-format YAML --tags "Key=SSMtag,Value=chaos" --region $REGION
done
