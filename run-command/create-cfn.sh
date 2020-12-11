#!/usr/bin/env bash
#
# Create CloudFormation template with SSM Run Commands in the repository.
# Reads YAML files from input path specified in first argument.
# Command expects the input path contains SSM Run Command documents.
# Outputs CloudFormation YAML template with all the SSM Run Commands.
#
# Usage:
# $ run-command/create-cfn.sh run-command/ | tee cfn-chaos-ssm.yml
# $ aws cloudformation create-stack --stack-name ChaosSsm --template-body file://cfn-chaos-ssm.yml
#
# Do not pipe CloudFormation template file to run-command/ directory to avoid an endless loop.

set -e

[ -d "$1" ] || (echo "$0: usage: $0 /path/to/run-command/" >&2 && exit 1)

cat <<EOF
AWSTemplateFormatVersion: 2010-09-09

Description: |
  Chaos Injection for AWS resources using Amazon SSM Run Command and Automation

Resources:
EOF

for document in "$1"/*.yml ; do
    file=$(basename "$document")
    resource=$(echo "$file" | sed -r 's/(^|-)([a-z])/\U\2/g' | cut -f1 -d.)
    cat <<EOF

  # $file
  $resource:
    Type: AWS::SSM::Document
    Properties:
      DocumentType: Command
      Content:
EOF
    sed -e '1d' -e 's/^/        /' < "$document"
    echo ""
done
