import json
import os
import boto3

sns = boto3.client(
    "sns",
    endpoint_url=os.environ.get("AWS_ENDPOINT_URL"),
    region_name=os.environ.get("AWS_REGION", "us-east-1"),
)

def handler(event, context):
    body = event.get("body", "{}")

    if isinstance(body, str):
        body = json.loads(body)

    response = sns.publish(
        TopicArn=os.environ["SNS_TOPIC_ARN"],
        Message=json.dumps(body),
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Event published",
            "message_id": response["MessageId"],
        }),
    }
