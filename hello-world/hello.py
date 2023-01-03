import os
import json
import boto3

tableName = "GameScores"
dynamotb = boto3.resource("dynamodb").Table(tableName)
dynamodb = boto3.resource("dynamodb", region_name=os.environ["AWS_REGION"])


def list_tables():
    """
    Lists the Amazon DynamoDB tables for the current account.

    :return: The list of tables.
    """
    try:
        tables = []
        for table in dynamodb.tables.all():
            print(table.name)
            tables.append(table)
    except ClientError as err:
        logger.error(
            "Couldn't list tables. Here's why: %s: %s",
            err.response["Error"]["Code"],
            err.response["Error"]["Message"],
        )
        raise
    else:
        return tables


def lambda_handler(event, context):
    action = json.loads(event["body"]).get("action")
    record = json.loads(event["body"]).get("record")
    json_region = os.environ["AWS_REGION"]
    tables = list_tables()
    print(tables)

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(
            {
                "Region ": json_region,
                "Tables": list(tables),
                "action": action,
                "record": record,
            }
        ),
    }
