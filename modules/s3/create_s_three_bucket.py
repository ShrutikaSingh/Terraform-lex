import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket_name = event.get("bucket_name", f"default-bucket-{context.aws_request_id}")
    print('BUCKET NAME:',bucket_name)
    
    try:
        # Create the S3 bucket
        s3.create_bucket(Bucket=bucket_name)
        # Return response in the format Lex expects
        return {
            "dialogAction": {
                "type": "Close",
                "fulfillmentState": "Fulfilled",
                "message": {
                    "contentType": "PlainText",
                    "content": f"S3 bucket {bucket_name} created successfully."
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
                    "content": f"Error creating bucket: {str(e)}"
                }
            }
        }
