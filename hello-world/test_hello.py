import pytest
from hello import lambda_handler


context = {
    "aws_request_id": "abcdef",
    "log_stream_name": "1f73402ad",
    "invoked_function_arn": "arn:aws:lambda:region:1000:function:TestCFStackNam-TestLambdaFunctionResourceName-ABC-1234F",
    "client_context": None,
    "log_group_name": "/aws/lambda/TestCFStackName-TestLambdaFunctionResourceName-ABC-1234F",
    "function_name": "TestCloudFormationStackName-TestLambdaFunctionResourceName--ABC-1234F",
    "function_version": "$LATEST",
    "identity": "<__main__.CognitoIdentity object at 0x1fb81abc00>",
    "memory_limit_in_mb": "128",
}

event = {"test": "event"}


def test_lambda_handler_sucess(monkeypatch):
    monkeypatch.setenv("AWS_REGION", "tomasz-region")
    happy_lambda = lambda_handler(context, event)
    assert happy_lambda == {
        "body": '{"Region ": "tomasz-region", "Message": "Hello world"}',
        "headers": {"Content-Type": "application/json"},
        "statusCode": 200,
    }
