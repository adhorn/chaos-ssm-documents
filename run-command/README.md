SSM Run Command documents:
==========================

To use SSM Run Command, please check [this
link](https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5)

**Support Canceling & Rollback (10s max)**

-   Support for latency injection using `latency-stress.yml`
-   Support for latency with delta stress using
   `latency-delta-stress.yml`
-   Support for CPU burn using `cpu-stress.yml`
-   Support for IO stress using `io-stress.yml`
-   Support for memory stress using `memory-stress.yml`
-   Support for network stress using `network-corruption-stress.yml`
-   Support for packet Loss stress using `network-loss-stress.yml`
-   Support for killing a process by name using `kill-process.yml`

**Experimental**

-   Support for configurable blackhole stress using
    `blackhole-stress.yml`
-   Support for blackhole S3 stress using `blackhole-s3-stress.yml`
-   Support for blackhole DynamoDB stress using
    `blackhole-dynamo-stress.yml`
-   Support for blackhole EC2 stress using `blackhole-ec2-stress.yml`
-   Support for blackhole DNS stress using `blackhole-dns-stress.yml`
-   Support for latency injection to a particular AWS service 
    `latency-service-stress.yml`

**Prerequisites**

-   [SSM
    Agent](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-ssm-agent.html)
    (Preinstalled on several Amazon Machine Images)
-   [stress-ng, tc, and
    jq](https://github.com/adhorn/chaos-ssm-documents/blob/master/run-command/install-dependencies.yml)
    (Automatic install of dependencies)