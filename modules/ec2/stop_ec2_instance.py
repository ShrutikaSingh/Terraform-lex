import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    print("Stoping EC2 instance ", event)
    print("check event")
    
    instance_id = event.get('currentIntent', {}).get('slots', {}).get('instance_id')

    print("tesing 2",instance_id )
    
    # Check if instance_id is provided
    if not instance_id:
        return {
            "dialogAction": {
                "type": "ElicitSlot",
                "slotToElicit": "instance_id",
                "message": {
                    "contentType": "PlainText",
                    "content": "Please provide the instance ID."
                }
            }
        }
    
    try:
        ec2.stop_instances(InstanceIds=[instance_id])
        return {
            "dialogAction": {
                "type": "Close",
                "fulfillmentState": "Fulfilled",
                "message": {
                    "contentType": "PlainText",
                    "content": f"EC2 Instance {instance_id} stopped successfully."
                }
            }
        }
    except Exception as e:
        return {
            "dialogAction": {
                "type": "Close",
                "fulfillmentState": "Failed",
                "message": {
                    "contentType": "PlainText",
                    "content": f"Error stopping EC2 instance: {str(e)}"
                }
            }
        }
