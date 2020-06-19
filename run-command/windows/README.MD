### Experimental
The Windows Run Commands are all currently experimental 
and should not be used until we have tested more throughly

### What is a Run Command?
Read [this blog](https://medium.com/@adhorn/injecting-chaos-to-amazon-ec2-using-amazon-system-manager-ca95ee7878f5) 
for background.

Run Command lets you remotely and securely manage the configuration of your 
instances, and not only EC2 instances, but also the ones configured 
in your hybrid environment. That includes on-premises servers and virtual machines (VMs) 
and even VMs in other cloud environments set for use with Systems Manager.

Run Command allows you to automate DevOps tasks or perform ad-hoc 
configuration updates, regardless of the size of your fleet.

For ad-hoc changes, you can use the AWS console. 
For regular tasks requiring automation, you can use either the 
AWS CLI, the AWS Tools for Windows PowerShell, or the AWS SDKs.
While Run Command is mostly used for tasks such as installing or 
bootstrapping applications, capturing log files or joining instances to a 
Windows domain, Run Command is also particularly well-suited to 
perform chaos experiments.

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

                     
