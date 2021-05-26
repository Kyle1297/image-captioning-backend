from accounts.models import Profile
from django.conf import settings
from ..utils import create_presigned_get, generate_s3_key, create_public_get
from rest_framework import serializers
from ..models import Image, Caption, Collection
from reports.serializers import ImageReportSerializer
from reports.models import ImageReport
from accounts.serializers import LimitedUserSerializer
from .collections import CollectionSerializer
from .captions import CaptionSerializer
from django.contrib.auth.models import User

class ImageSerializer(serializers.ModelSerializer):
    caption = CaptionSerializer(required=False)
    uploader = LimitedUserSerializer(allow_null=True)
    collections = CollectionSerializer(read_only=True, many=True)
    collection_ids = serializers.ListField(required=False, write_only=True, child=serializers.IntegerField(min_value=0), allow_empty=True)
    comments_count = serializers.SerializerMethodField(read_only=True)
    image = serializers.SerializerMethodField(read_only=True)
    report = ImageReportSerializer(required=False, write_only=True)

    class Meta:
        model = Image
        fields = '__all__'
        extra_kwargs = {
            's3_key': {
                'read_only': True,
            },
            'uuid': {
                'read_only': False,
            },
            'last_updated': {
                'read_only': True,
            },
            'uploaded_at': {
                'read_only': True,
            },
        }

    def create(self, validated_data):
        # retrieve key values
        caption = validated_data.pop('caption', None)
        collection_ids = validated_data.pop('collection_ids', None)
        uploader = validated_data.pop('uploader')
        uuid = str(validated_data['uuid'])
        type = validated_data['type']
        is_private = validated_data['is_private']
        is_profile_image = validated_data['is_profile_image']

        # generate s3 key
        filename = uuid + '.' + type
        key = generate_s3_key(is_profile_image, is_private, filename)
        
        # create image
        image = None
        if uploader:
            uploader = User.objects.get(id=uploader['id'])
            image = Image.objects.create(s3_key=key, uploader=uploader, **validated_data)
        else:
            uploader = User.objects.get(username="Anonymous")
            image = Image.objects.create(s3_key=key, uploader=uploader, **validated_data)

        # update user's profile image
        if is_profile_image and uploader:
            uploader.profile.image = image
            uploader.save()

        # add collections to image and create associated caption
        elif caption and collection_ids:
            collections = Collection.objects.filter(id__in=collection_ids)
            image.collections.set(collections)
            Caption.objects.create(text=caption['text'], corrected_text="", image=image)

        return image

    def update(self, instance: Image, validated_data): 
        # create new report, if desired
        if validated_data.get('report'):
            report = validated_data.pop('report')
            ImageReport.objects.create(image=instance, **report)

        # then, update accordingly
        return super().update(instance, validated_data)  

    def get_image(self, obj: Image):
        filename = obj.title + '.' + obj.type
        return create_presigned_get(settings.AWS_MEDIA_BUCKET_NAME, obj.s3_key, filename)

    def get_comments_count(self, obj: Image):
        return obj.comments.count()
