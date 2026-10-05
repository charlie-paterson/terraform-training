import json
import os
import boto3

dynamodb = boto3.resource(
    "dynamodb",
    endpoint_url=os.environ.get("AWS_ENDPOINT_URL"),
    region_name=os.environ.get("AWS_REGION", "us-east-1"),
)

table = dynamodb.Table(os.environ["DYNAMODB_TABLE"])


def handler(event, context):
    processed = 0

    for record in event.get("Records", []):
        message = json.loads(record["body"])

        table.put_item(
            Item={
                "id": message.get("id", record["messageId"]),
                "message": json.dumps(message),
            }
        )

        processed += 1

    return {
        "statusCode": 200,
        "processed": processed,
    }
