from rest_framework import serializers
from ..models import Image, Caption, Comment, Collection
from .users import LimitedUserSerializer
from .collections import LimitedCollectionSerializer
from .comments import LimitedCommentSerializer
from .captions import LimitedCaptionSerializer


class ImageSerializer(serializers.ModelSerializer):
    caption = LimitedCaptionSerializer()
    uploader = LimitedUserSerializer(read_only=True)
    comments = LimitedCommentSerializer(read_only=True, many=True)
    collections = LimitedCollectionSerializer(read_only=True, many=True)

    class Meta:
        model = Image
        fields = '__all__'