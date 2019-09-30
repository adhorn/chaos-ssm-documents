
Chaos Injection for Amazon EC2 instances or containers using SSM
================================================================

|issues| |maintenance| |twitter| 


.. |twitter| image:: https://img.shields.io/twitter/url/https/github.com/adhorn/chaos-ssm-documents?style=social
    :alt: Twitter
    :target: https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fadhorn%2Fchaos-ssm-documents

.. |issues| image:: https://img.shields.io/github/issues/adhorn/chaos-ssm-documents
    :alt: Issues

.. |maintenance| image:: https://img.shields.io/badge/Maintained%3F-yes-green.svg
    :alt: Maintenance
    :target: https://gitHub.com/adhorn/chaos-ssm-documents/graphs/commit-activity



Collection of `SSM Documents <https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html/>`_.
This allows to conduct small chaos engineering experiments for your Amazon EC2 instances and container based applications
in the `AWS Cloud <https://aws.amazon.com>`_.

To learn how to use these SSM Documents - please check `this link <https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5>`_

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

Upload all of the SSM Documents to the AWS region of your choice
----------------------------------------------------------------

.. code:: shell

    git clone git@github.com:adhorn/chaos-ssm-documents.git

    cd chaos-ssm-documents

    ./upload-document.sh -r eu-west-2 (or other region of your choice)

Upload one document at a time
-----------------------------

.. code:: shell
    
    aws ssm create-document --content file://cpu-stress.yml --name "cpu-stress" --document-type "Command" --document-format YAML


SOME WORDS OF CAUTION BEFORE YOU START BREAKING THINGS:
-------------------------------------------------------

* To begin with, DO NOT use these chaos injection commands in production blindly!!
* Always review the SSM documents and the commands in them.
* Make sure your first chaos injections are done in a test environment and on test instances where no real and paying customer can be affected.
* Test, test, and test more. Remember that chaos engineering is about breaking things in a controlled environment and through well-planned experiments to build confidence in your application — and you own tools — to withstand turbulent conditions.

More information:
-----------------

`Please read the following Blog post to understand in details how to use these SSM Documents. <https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5>`_