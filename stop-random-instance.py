import boto3
import random

REGION = 'eu-west-1'


def stop_random_instance(az, tag_name, tag_value, region=REGION):
    '''
    >>> stop_random_instance(
        az="eu-west-1b", tag_name='SSMTag', tag_value="chaos-ready")
    ['i-0ddce3c81bc836560']
    '''
    ec2 = boto3.client("ec2", region_name=region)
    paginator = ec2.get_paginator('describe_instances')
    pages = paginator.paginate(
        Filters=[
            {
                "Name": "availability-zone",
                "Values": [
                    az
                ]
            },
            {
                "Name": "tag:" + tag_name,
                "Values": [
                    tag_value
                ]
            }
        ]
    )
    instance_list = []
    for page in pages:
        for reservation in page['Reservations']:
            for instance in reservation['Instances']:
                instance_list.append(instance['InstanceId'])
    print("Going to stop ANY of these instance", instance_list)
    selected_instance = random.choice(instance_list)
    print("Randomly selected", selected_instance)
    response = ec2.stop_instances(InstanceIds=[selected_instance])
    return response
