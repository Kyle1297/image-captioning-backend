import json, requests, logging
from ..serializers.utils import POST
from rest_framework import response, generics, views
from django.conf import settings
from django.http import HttpRequest, HttpResponse
from ..utils import create_presigned_get, create_presigned_post, generate_s3_key, upper_text
from ..serializers import SignS3Serializer
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

class SignS3Upload(generics.GenericAPIView):
    serializer_class = SignS3Serializer

    def get(self, request: HttpRequest, *args, **kwargs) -> HttpResponse:
        # serializer
        serializer = self.get_serializer(data=request.GET.dict())
        serializer.is_valid(raise_exception=True)
        parameters = serializer.validated_data

        # key parameters
        s3_bucket = settings.AWS_MEDIA_BUCKET_NAME
        method = parameters['method']
        uuid = parameters['uuid']
        file_type = parameters['file_type']
        is_profile_image = parameters['is_profile_image']
        is_private = parameters['is_private']

        # create s3 key
        filename = uuid + '.' + file_type
        object = generate_s3_key(is_profile_image, is_private, filename)

        # retrieve presigned url
        presigned_url = {}
        if method == POST:
            # allow posting to s3
            fields = {
                "Content-Type": file_type,
            }
            conditions = [
                {
                    "Content-Type": file_type
                }
            ]
            presigned_url = create_presigned_post(s3_bucket, object, fields, conditions)

        else:
            # allow object retreival from s3
            presigned_url = create_presigned_get(s3_bucket, object, filename)

        # return presigned url
        data = {
            "signed_url": presigned_url,
            'url': f'https://{s3_bucket}.s3.amazonaws.com/',
        }
        return response.Response(data) 


class CaptionSNS(views.APIView):

    def post(self, request: HttpRequest, *args, **kwargs) -> HttpResponse:
        # confirm subscription
        data = json.loads(request.body)
        if data["Type"] == 'SubscriptionConfirmation':
            if self.confirm_subscription(data):
                return response.Response("Subscription was confirmed.")
            else:
                return response.Response("Subscription was not confirmed.")

        # handle notification from lambda caption generator 
        elif data["Type"] == 'Notification':
            try:
                # retrieve key parameters
                message = json.loads(data["Message"])
                key = message["requestPayload"]["Records"][0]["s3"]["object"]["key"]
                uuid = key.split("/")[-1].split(".")[0]

                # send caption to channel
                if uuid == kwargs['uuid']:
                    caption = upper_text(message["responsePayload"])
                    layer = get_channel_layer()
                    async_to_sync(layer.group_send)(
                        uuid, 
                        {
                            "type": "caption", 
                            "caption": caption ,
                        }
                    )
                    return response.Response("Correct notification received.")
            except Exception:
                return response.Response("Wrong notification received.")
        return response.Response("Neither subscription confirmation or notification was received.")

    def confirm_subscription(self, data):
        try: 
            requests.get(data['SubscribeURL'])
            return True
        except IOError as error:
            logging.error(error)
            return False