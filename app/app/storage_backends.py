from storages.backends.s3boto3 import S3Boto3Storage
from django.conf import settings


class StaticStorage(S3Boto3Storage):
    bucket_name = settings.AWS_STATIC_BUCKET_NAME
    custom_domain = settings.AWS_S3_STATIC_DOMAIN
    default_acl = 'public-read'


class MediaStorage(S3Boto3Storage):
    bucket_name = settings.AWS_MEDIA_BUCKET_NAME
    default_acl = 'private'
    file_overwrite = True
    custom_domain = False