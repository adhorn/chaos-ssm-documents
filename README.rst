
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

* Support for Latency injection using ``latency-stress.yml``
* Support for CPU burn using ``spu-stress.yml``
* Support for IO stress using ``io-stress.yml``
* Support for Memory stress using ``memory-stress.yml``
* Support for blackhole stress using ``blackhole-stress.yml``

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


More information:
-----------------

`Blog post <https://www.medium.com/@adhorn>`_
