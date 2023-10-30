import json
import boto3
import uuid

def lambda_handler(event, context):
    # TODO implement
    message = event["Records"][0]["Sns"]["Message"]
    #   message_from_sns = json.loads(event["Records"][0]["Sns"])
    #   message_from_sqs = message_from_sns["Message"]
    
    file_name = str(uuid.uuid4())
    
    client = boto3.client('dynamodb')
    response = client.put_item(
    TableName='UE123-Table',
    Item={
        'Id': {
            'S': file_name,
        },
        'Message': {
            'S': message
        }
    }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hier kommt die Nachricht mit der Nr: '+file_name)
    }