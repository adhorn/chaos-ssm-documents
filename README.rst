
Chaos Injection for AWS resources using Amazon SSM Run Command and Automation
=========================================================================

|issues| |maintenance| |twitter| 


.. |twitter| image:: https://img.shields.io/twitter/url/https/github.com/adhorn/chaos-ssm-documents?style=social
    :alt: Twitter
    :target: https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fadhorn%2Fchaos-ssm-documents

.. |issues| image:: https://img.shields.io/github/issues/adhorn/chaos-ssm-documents
    :alt: Issues

.. |maintenance| image:: https://img.shields.io/badge/Maintained%3F-yes-green.svg
    :alt: Maintenance
    :target: https://gitHub.com/adhorn/chaos-ssm-documents/graphs/commit-activity


Collection of `SSM Documents <https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html>`_.

These documents let you perform chaos engineering experiments on resources (applications, network, and infrastructure)
in the `AWS Cloud <https://aws.amazon.com>`_.


SSM Automation documents:
-------------------------
To use SSM Automation, check `the link <https://medium.com/@adhorn/creating-your-own-chaos-monkey-with-aws-systems-manager-automation-6ad2b06acf20>`_

* Support for (randomly) stopping EC2 instances via API
* Support for (randomly) stopping EC2 instances via AWS Lambda
* Support for (randomly) terminating EC2 instances via API
* Support for detaching EBS volumes from EC2 instances via API (ec2, ebs)
* Support for rebooting RDS instance with proper tags via API
* Support for CPU stress scenario via Run Command


Upload an SSM Automation document:
----------------------------------

.. code:: shell
    
    aws ssm create-document --name "StopRandomInstances-API" --content file://stop-random-instance-api.yml --document-type "Automation" --document-format YAML


SSM Run Command documents:
--------------------------
To use SSM Run Command, please check `this link <https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5>`_

* Support for latency injection to a particular AWS service ``latency-service-stress.yml``
* Support for latency injection using ``latency-stress.yml``
* Support for latency with delta stress using ``latency-delta-stress.yml``
* Support for CPU burn using ``spu-stress.yml``
* Support for IO stress using ``io-stress.yml``
* Support for memory stress using ``memory-stress.yml``
* Support for network stress using ``network-corruption-stress.yml``
* Support for packet Loss stress using ``network-loss-stress.yml``
* Support for configurable blackhole stress using ``blackhole-stress.yml``
* Support for blackhole S3 stress using ``blackhole-s3-stress.yml``
* Support for blackhole DynamoDB stress using ``blackhole-dynamo-stress.yml``
* Support for blackhole EC2 stress using ``blackhole-ec2-stress.yml``
* Support for blackhole DNS stress using ``blackhole-dns-stress.yml``

**Prerequisites**

* `SSM Agent <https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-ssm-agent.html>`_ (Preinstalled on several Amazon Machine Images)
* `stress-ng, tc, and jq <https://github.com/adhorn/chaos-ssm-documents/blob/master/run-command/install-dependencies.yml>`_ (Automatic install of dependencies)


Upload one document at a time
-----------------------------

.. code:: shell

    cd chaos-ssm-documents/automation

    aws ssm create-document --content file://cpu-stress.yml --name "cpu-stress" --document-type "Command" --document-format YAML


Upload all of the SSM Documents to the AWS region of your choice
----------------------------------------------------------------

.. code:: shell

    cd chaos-ssm-documents/run-command

    ./upload-document.sh -r eu-west-1 (or other region of your choice)

Upload all of the SSM Documents using CloudFormation
----------------------------------------------------

.. code:: shell

    cd chaos-ssm-documents/

    run-command/create-cfn.sh run-command/ | tee cfn-chaos-ssm.yml

    aws cloudformation create-stack --stack-name ChaosSsm --template-body file://cfn-chaos-ssm.yml

Specify AWS region using AWS CLI --region argument.

Once deployed, the stack cannot be updated.
Remove existing stack and re-deploy to apply changes.

SOME WORDS OF CAUTION BEFORE YOU START BREAKING THINGS:
-------------------------------------------------------

* To begin with, DO NOT use these chaos injection commands in production blindly!!
* Always review the SSM documents and the commands in them.
* Make sure your first chaos injections are done in a test environment and on test instances where no real and paying customer can be affected.
* Test, test, and test more. Remember that chaos engineering is about breaking things in a controlled environment and through well-planned experiments to build confidence in your application — and you own tools — to withstand turbulent conditions.


One-click Deploy via CloudFormation
-----------------------------------

| US East (N. Virginia) ``us-east-1``         | `Launch Stack <https//us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| US East (Ohio) ``us-east-2``                | `Launch Stack <https//us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| US West (N. California) ``us-west-1``       | `Launch Stack <https//us-west-1.console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| US West (Oregon) ``us-west-2``              | `Launch Stack <https//us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Canada (Central) ``ca-central-1``           | `Launch Stack <https//ca-central-1.console.aws.amazon.com/cloudformation/home?region=ca-central-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__     |
| Africa (Cape Town) ``af-south-1``           | `Launch Stack <https//af-south-1.console.aws.amazon.com/cloudformation/home?region=af-south-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__         |
| Asia Pacific (Hong Kong) ``ap-east-1``      | `Launch Stack <https//ap-east-1.console.aws.amazon.com/cloudformation/home?region=ap-east-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Asia Pacific (Mumbai) ``ap-south-1``        | `Launch Stack <https//ap-south-1.console.aws.amazon.com/cloudformation/home?region=ap-south-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Asia Pacific (Seoul) ``ap-northeast-2``     | `Launch Stack <https//ap-northeast-2.console.aws.amazon.com/cloudformation/home?region=ap-northeast-2#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Asia Pacific (Singapore) ``ap-southeast-1`` | `Launch Stack <https//ap-southeast-1.console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Asia Pacific (Sydney) ``ap-southeast-2``    | `Launch Stack <https//ap-southeast-2.console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Asia Pacific (Tokyo) ``ap-northeast-1``     | `Launch Stack <https//ap-northeast-1.console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Europe (Frankfurt) ``eu-central-1``         | `Launch Stack <https//eu-central-1.console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Europe (Ireland) ``eu-west-1``              | `Launch Stack <https//eu-west-1.console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Europe (London) ``eu-west-2``               | `Launch Stack <https//eu-west-2.console.aws.amazon.com/cloudformation/home?region=eu-west-2#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Europe (Paris) ``eu-west-3``                | `Launch Stack <https//eu-west-3.console.aws.amazon.com/cloudformation/home?region=eu-west-3#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Europe (Stockholm) ``eu-north-1``           | `Launch Stack <https//eu-north-1.console.aws.amazon.com/cloudformation/home?region=eu-north-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| Middle East (Bahrain) ``me-south-1``        | `Launch Stack <https//me-south-1.console.aws.amazon.com/cloudformation/home?region=me-south-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
| South America (São Paulo) ``sa-east-1``     | `Launch Stack <https//sa-east-1.console.aws.amazon.com/cloudformation/home?region=sa-east-1#/stacks/create/review?templateURL=https://chaos-ssm-documents.s3.amazonaws.com/cfn-chaos-ssm.yml&stackName=ChaosSsm>`__ |
