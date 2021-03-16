import boto3, logging
from typing import List
from botocore.exceptions import ClientError


s3_client = boto3.client('s3')

def create_presigned_get(bucket_name: str, object_name: str, expiration: int = 3600) -> dict:
    """
    Generate a presigned URL to share an S3 object.

    :param bucket_name: string
    :param object_name: string
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Presigned URL as string. If error, returns None.
    """

    # Generate a presigned URL for the S3 object
    s3_client = boto3.client('s3')
    try:
        presigned_get = s3_client.generate_presigned_url('get_object',
                                                    Params={'Bucket': bucket_name,
                                                            'Key': object_name},
                                                    ExpiresIn=expiration)
    except ClientError as error:
        logging.error(error)
        return None

    # The response contains the presigned URL
    return presigned_get


def create_presigned_post(bucket_name: str, object_name: str, fields: dict = None, 
                          conditions: List = None, expiration: int = 3600) -> dict:
    """
    Generate a presigned URL S3 POST request to upload a file.

    :param bucket_name: string
    :param object_name: string
    :param fields: Dictionary of prefilled form fields
    :param conditions: List of conditions to include in the policy
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Dictionary with the following keys:
        url: URL to post to
        fields: Dictionary of form fields and values to submit with the POST
    :return: None if error.
    """

    # Generate a presigned S3 POST URL
    s3_client = boto3.client('s3')
    try:
        presigned_post = s3_client.generate_presigned_post(bucket_name,
                                                     object_name,
                                                     Fields=fields,
                                                     Conditions=conditions,
                                                     ExpiresIn=expiration)
    except ClientError as error:
        logging.error(error)
        return None

    # The response contains the presigned URL and required fields
    return presigned_post