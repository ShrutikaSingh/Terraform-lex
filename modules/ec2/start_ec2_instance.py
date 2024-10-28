import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = event['instance_id']  # Pass instance ID through event
    print(instance_id)
    ec2.start_instances(InstanceIds=[instance_id])
    return {
        'statusCode': 200,
        'body': f'EC2 Instance {instance_id} started successfully.'
    }
