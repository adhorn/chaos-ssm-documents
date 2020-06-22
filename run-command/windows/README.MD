### Experimental
The Windows Run Commands are all currently experimental 
and should not be used until we have tested more throughly

### What is a Run Command?
Read [this blog](https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5) 
for background.


### SSM Document
An SSM document defines the actions that Systems 
Manager performs on your instances. 

SSM documents use JSON or YAML format, and they include steps and 
parameters that you specify to perform your failure injection. 
These SSM documents are useful since they allow you to (1) 
create and save different versions of your documents and specify 
the default version for each SSM document. Changing or updating 
the content of the SSM document will automatically increment 
the version of the SSM document.

Each of the items in this folder are an SSM document.

To use them we can upload them to our AWS account using the following command.

Using the CLI:
```bash
aws ssm create-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-type "Command" --document-format YAML
```
To Update the document:
```bash
aws ssm update-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-version '$LATEST'
```
To Update the document on Windows:
```bash
aws ssm update-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-version "$LATEST"
```
TODO: Add PowerShell Command here too

### blackhole-dns-stress
This SSM document blackholes DNS, effectively switching off DNS on the instance. 
Standard commands like NSlookup will fail, and applications on the instance that 
require DNS lookups will fail to work. 

The DNS will fail to resolve for the duration of the time specified in the duration parameter.

To achieve this this, the DNS server IP address, that is specified 
by the network card, is added as an entry to the firewall and set to deny. 

This seems to work well, however, I do not invalidate any DNS caches. Therefore I need to test this
further to ensure that it will actually stop DNS requests in regular applications in the way 
I have assumed it will.

The document includes two tests. After blocking the DNS IP address, the document runs a Resolve-DnsName cmdlet
attempting to resolve www.amazon.com. The results of this test will show up in your logs. 

The same test runs again after the DNS IP Address is removed from the firewall. These test will not fail
or halt the SSM document, but the results are available to see in the logs, should you wish to validate 
that the DNS did stop working.

TODO: Need to validate what happens when the instance has more than one network card attached. 

Using the CLI:
```bash
aws ssm create-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-type "Command" --document-format YAML
```
To Update the document:
```bash
aws ssm update-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-version '$LATEST'
```
To Update the document on Windows:
```bash
aws ssm update-document --content file://blackhole-dns-stress.yml --name "blackhole-dns-stress" --document-version "$LATEST"
```
### blackhole-dynamo-stress.yml

This document loops through an array of dynamo addresses and add them to the firewall. 
It then removes them after the specified duration.

Using the CLI:
```bash
aws ssm create-document --content file://blackhole-dynamo-stress.yml --name "blackhole-dynamo-stress" --document-type "Command" --document-format YAML
```
To Update the document:
```bash
aws ssm update-document --content file://blackhole-dynamo-stress.yml --name "blackhole-dynamo-stress" --document-version '$LATEST'
```
To Update the document on Windows:
```bash
aws ssm update-document --content file://blackhole-dynamo-stress.yml --name "blackhole-dynamo-stress" --document-version "$LATEST"
```
                     
