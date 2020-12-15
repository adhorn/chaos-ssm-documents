#!/usr/bin/env bash
#
# Create CloudFormation template from SSM Run Command documents in directory.
#
#  - Reads YAML files from input path specified in first argument.
#  - Command expects the input path contains SSM Run Command documents.
#  - Outputs CloudFormation YAML template with all the SSM Run Commands.
#
# Usage:
# $ run-command/create-cfn.sh run-command/ | tee cfn-chaos-ssm.yml
# $ aws cloudformation create-stack --stack-name ChaosSsm --template-body file://cfn-chaos-ssm.yml
#
# Resulting stack cannot be updated by using aws cloudformation update-stack
# To update, first delete existing stack and then re-create it as above.
#
# Do not pipe CloudFormation template file to run-command/ directory to avoid an endless loop.

[ -d "$1" ] || (echo "$0: usage: $0 /path/to/run-command/" >&2 && exit 1)

head=$(git rev-parse HEAD)

set -e

cat <<EOF
# https://github.com/adhorn/chaos-ssm-documents
# $head
AWSTemplateFormatVersion: 2010-09-09

Description: |
  Chaos Injection for AWS resources using Amazon SSM Run Command and Automation

Resources:
EOF

for document in "$1"/*.yml ; do
    file=$(basename "$document")
    resource=$(echo "$file" | cut -f1 -d. | perl -pe 's/([a-z0-9]+)|./\u$1/g')
    cat <<EOF

  # $file
  $resource:
    Type: AWS::SSM::Document
    Properties:
      Name: !Sub \${AWS::StackName}-$resource
      DocumentType: Command
      Content:
EOF
    sed -e '1d' -e 's/^/        /' < "$document"
    echo ""
done
