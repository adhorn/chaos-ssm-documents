SSM Run Command documents:
==========================

To use SSM Run Command, please check [this
link](https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5)

**Support Canceling & Rollback (10s max)**


-   Support for killing a process by name using `kill-process.yml`
-   Support for CPU stress using `cpu-stress.yml`
-   Support for IO stress using `io-stress.yml`
-   Support for memory stress using `memory-stress.yml`
-   Support for diskspace stress using `diskspace-stress.yml`
-   Support for latency injection to network traffic on a particular network interface using `latency-stress.yml`
-   Support for latency injection with jitter to outgoing or incoming traffic from a configurable list of sources (Supported: IPv4, IPv4/CIDR, Domain name, DYNAMODB|S3) using `latency-stress-sources.yml`
-   Support for packet loss injection to network traffic on a particular network interface using `network-loss-stress.yml`
-   Support for packet loss injection to outgoing or incoming traffic from a configurable list of sources (Supported: IPv4, IPv4/CIDR, Domain name, DYNAMODB|S3) using `network-loss-sources.yml`


**Experimental**

-   Support for blackhole S3 stress using `blackhole-s3-stress.yml`
-   Support for blackhole DynamoDB stress using `blackhole-dynamo-stress.yml`
-   Support for blackhole EC2 stress using `blackhole-ec2-stress.yml`

**Prerequisites**

-   [SSM
    Agent](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-ssm-agent.html)
    (Preinstalled on several Amazon Machine Images)
-   [stress-ng, tc, and
    jq](https://github.com/adhorn/chaos-ssm-documents/blob/master/run-command/install-dependencies.yml)
    (Automatic install of dependencies)