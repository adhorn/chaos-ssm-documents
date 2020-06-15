import boto3
import random
import time


def stop_random_instance(ec2_client, az_name, tag):
    paginator = ec2_client.get_paginator('describe_instances')
    pages = paginator.paginate(
        Filters=[
            {
                "Name": "availability-zone",
                "Values": [
                    az_name
                ]
            },
            {
                "Name": "tag:" + tag.split(':')[0],
                "Values": [
                    tag.split(':')[1]
                ]
            },
            {
                "Name": "instance-state-name",
                "Values": [
                    "running"
                ]
            }
        ]
    )
    instance_list = []
    for page in pages:
        for reservation in page['Reservations']:
            for instance in reservation['Instances']:
                instance_list.append(instance['InstanceId'])
    print("Going to stop ANY of these instance %s ", instance_list)
    if len(instance_list) > 0:
        selected_instance = random.choice(instance_list)
        print("Randomly selected %s", selected_instance)
        ec2_client.stop_instances(
            InstanceIds=[selected_instance]
        )
        return selected_instance
    else:
        print(
            "No instance in running state in %s with tag %s",
            az_name, tag)


def rollback(ec2_client, instance_id):
    print('Restarting the instance %s', instance_id)
    ec2_client.start_instances(
            InstanceIds=[instance_id]
    )


def run(az_name, tag, duration=60, log_level='INFO'):
    print('Setting up ec2 client')
    ec2_client = boto3.client('ec2')
    instance_id = stop_random_instance(
        ec2_client, az_name, tag)

    if instance_id and duration:
        print('Attempting to rollback')
        time.sleep(duration)
        rollback(ec2_client, instance_id)


def entry_point(event, context):
    print("Event received: %s ", event)
    run(
        event["availabilityZone"],
        event["tagValue"]
    )

    return {
        "message": "Random instance stopped!",
        "input": event
    }
