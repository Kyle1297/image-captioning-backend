import boto3, logging
from typing import List
from botocore.exceptions import ClientError
from botocore.config import Config
from botocore import UNSIGNED
from django.conf import settings

s3_private_client = boto3.client("s3", 
                                 config=Config(signature_version='s3v4'),
                                 region_name=settings.AWS_DEFAULT_REGION,
                                 aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                                 aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY)

s3_public_client = boto3.client('s3', 
                                config=Config(signature_version=UNSIGNED), 
                                region_name=settings.AWS_DEFAULT_REGION)

def create_public_get(bucket_name: str, key: str):
    public_url = s3_public_client.generate_presigned_url(ClientMethod='get_object', 
                                                         ExpiresIn=0, 
                                                         Params={
                                                             'Bucket': bucket_name, 
                                                             'Key': key,
                                                             
                                                         })
    return public_url

def create_presigned_get(bucket_name: str, object_name: str, filename: str, expiration: int = 3600) -> dict:
    """
    Generate a presigned URL to share an S3 object.

    :param bucket_name: string
    :param object_name: string
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Presigned URL as string. If error, returns None.
    """

    # Generate a presigned URL for the S3 object
    try:
        presigned_get = s3_private_client.generate_presigned_url('get_object',
                                                    Params={'Bucket': bucket_name,
                                                            'Key': object_name,
                                                            'ResponseContentDisposition': f'attachment; filename={filename}',
                                                            },
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
    try:
        presigned_post = s3_private_client.generate_presigned_post(bucket_name,
                                                     object_name,
                                                     Fields=fields,
                                                     Conditions=conditions,
                                                     ExpiresIn=expiration)
    except ClientError as error:
        logging.error(error)
        return None

    # The response contains the presigned URL and required fields
    return presigned_post