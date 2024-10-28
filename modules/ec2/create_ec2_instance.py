import boto3
import logging
import json

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def get_latest_ami_id():
    """Fetch the latest available Amazon Linux 2 AMI ID by sorting the results."""
    ec2_client = boto3.client('ec2')
    
    # Fetch available AMIs for Amazon Linux 2
    response = ec2_client.describe_images(
        Filters=[
            {
                'Name': 'state',
                'Values': ['available']
            }
        ],
        Owners=['amazon'],
        MaxResults=10  # Fetch a few images and then sort by creation date
    )
    
    # Sort images by CreationDate (newest first)
    images = sorted(response['Images'], key=lambda x: x['CreationDate'], reverse=True)
    
    if not images:
        raise Exception("No valid AMI found.")
    
    ami_id = images[0]['ImageId']  # The latest image
    return ami_id

def lambda_handler(event, context):
    try:
        logger.info("Starting EC2 instance creation...")
        
        # Get the latest available AMI ID in the region
        ami_id = get_latest_ami_id()
        logger.info(f"Using AMI ID: {ami_id}")
        
        ec2 = boto3.resource('ec2')
        
        # Create the EC2 instance using the fetched AMI ID
        instances = ec2.create_instances(
            ImageId=ami_id,
            MinCount=1,
            MaxCount=1,
            InstanceType='t2.micro'
        )
        
        instance_id = instances[0].id
        instance_state = instances[0].state['Name']  # Fetch instance state (pending/running)

        # Return response in a format that Lex understands
        response_content = {
            'dialogAction': {
                'type': 'Close',
                'fulfillmentState': 'Fulfilled',
                'message': {
                    'contentType': 'PlainText',
                    'content': f'EC2 Instance {instance_id} created successfully with state {instance_state}.'
                }
            }
        }
        
        return {
            'statusCode': 200,
            'body': json.dumps(response_content)
        }
    except Exception as e:
        logger.error(f"Error creating EC2 instance: {str(e)}")
        
        error_response = {
            'dialogAction': {
                'type': 'Close',
                'fulfillmentState': 'Failed',
                'message': {
                    'contentType': 'PlainText',
                    'content': f'Error creating EC2 instance: {str(e)}'
                }
            }
        }
        
        return {
            'statusCode': 500,
            'body': json.dumps(error_response)
        }
