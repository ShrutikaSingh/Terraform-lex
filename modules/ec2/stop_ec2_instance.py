import boto3

def lambda_handler(event, context):
    print("here")
    ec2 = boto3.client('ec2')
    instance_id = event['instance_id']  # Pass instance ID through event
    ec2.stop_instances(InstanceIds=[instance_id])
    
    return {
        'statusCode': 200,
        'body': f'EC2 Instance {instance_id} stopped successfully.'
    }
