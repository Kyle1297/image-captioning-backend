import boto3, mimetypes
from rest_framework import response, views
from django.conf import settings
from django.http import HttpRequest, HttpResponse
from ..utils import create_presigned_get, create_presigned_post


s3_client = boto3.client('s3')

class SignS3Upload(views.APIView):

    def get(self, request: HttpRequest, file_name: str = "x", method: str = 'GET') -> HttpResponse:
        # set s3 bucket and object key
        s3_bucket = settings.AWS_MEDIA_BUCKET_NAME

        # retrieve presigned url
        presigned_url = {}
        if method == 'POST':
            # allow posting to s3
            file_type = mimetypes.guess_type(file_name)[0]
            fields = {
                "acl": "public-read", 
                "Content-Type": file_type
            }
            conditions = [
                {
                    "acl": "public-read"
                },
                {
                    "Content-Type": file_type
                }
            ]
            presigned_url = create_presigned_post(s3_bucket, file_name, fields, conditions)

        else:
            # allow object retreival from s3
            presigned_url = create_presigned_get(s3_bucket, file_name)

        # return presigned url
        data = {
            "signed_url": presigned_url,
            'url': f'https://{s3_bucket}.s3.amazonaws.com/{file_name}',
        }
        return response.Response(data) 